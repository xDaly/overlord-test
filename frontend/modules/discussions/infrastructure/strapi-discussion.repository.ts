import { AppError } from "@/lib/errors"
import type { StrapiClient, StrapiList, StrapiOne } from "@/lib/strapi-client"
import type { StrapiParams } from "@/lib/strapi-query"
import { unknownCategory, type Category } from "@/modules/categories/domain/category"
import type { Published, UsefulResult } from "@/modules/community/application/deps"
import type { UserRepository } from "@/modules/users/application/user.repository"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import { unknownUser } from "@/modules/users/infrastructure/strapi-member"
import type { AuthoredReply, DiscussionRepository, SolutionResult, VoteResult } from "../application/discussion.repository"
import type { Discussion, DiscussionDetail, ListDiscussionsQuery, Page, Reply } from "../domain/discussion"
import type { NewDiscussionInput } from "../domain/discussion.rules"
import type { SimilarCandidate } from "../domain/feed"
import { toDetail, toDiscussion, toReply, type MapContext } from "./strapi-discussion.mapper"
import type { StrapiDiscussionEntry, StrapiReplyEntry } from "./strapi-types"

export type Viewer = { id: number; username: string; token: string }

type Deps = {
  client: StrapiClient
  users: Pick<UserRepository, "list">
  viewer: () => Promise<Viewer | null>
  categories: () => Promise<Category[]>
}

const DEFAULT_PAGE_SIZE = 50
const MAX_PAGE_SIZE = 100
const SEARCH_LIMIT = 20
const BY_AUTHOR_LIMIT = 50

const MEMBER = { fields: ["username", "displayName"] }
const IDS = { fields: ["id"] }

const SUMMARY_POPULATE: StrapiParams = {
  category: { fields: ["slug", "name"] },
  author: MEMBER,
  usefulBy: IDS,
  followedBy: IDS,
  replies: {
    fields: ["createdAt", "usefulBase", "isBestAnswer", "verified"],
    sort: ["createdAt:asc"],
    populate: { author: MEMBER, usefulBy: IDS },
  },
}

const DETAIL_POPULATE: StrapiParams = {
  ...SUMMARY_POPULATE,
  replies: { sort: ["createdAt:asc"], populate: { author: MEMBER, usefulBy: IDS } },
}

const isNotFound = (error: unknown) => (error as { code?: string } | null)?.code === "not-found"

type CreatedMeta = { meta?: { effects?: Effect[]; mentioned?: { name: string }[] } }

const publishedMeta = (created: CreatedMeta) => ({
  effects: created.meta?.effects ?? [],
  mentioned: (created.meta?.mentioned ?? []).map((member) => member.name),
})

const searchFilter = (text: string): StrapiParams => ({
  $or: [{ title: { $containsi: text } }, { content: { $containsi: text } }],
})

export class StrapiDiscussionRepository implements DiscussionRepository {
  constructor(private readonly deps: Deps) {}

  private async context(): Promise<MapContext> {
    const [viewer, users, categories] = await Promise.all([this.deps.viewer(), this.deps.users.list(), this.deps.categories()])
    const byName = new Map(users.map((user) => [user.username, user]))
    const bySlug = new Map(categories.map((category) => [category.slug, category]))
    return {
      viewerId: viewer?.id ?? null,
      user: (username) => byName.get(username) ?? unknownUser(username),
      category: (slug, name) => bySlug.get(slug) ?? unknownCategory(slug, name),
    }
  }

  private async memberToken(): Promise<string> {
    const viewer = await this.deps.viewer()
    if (!viewer) throw new AppError("unauthenticated")
    return viewer.token
  }

  private async documentIdOf(slug: string): Promise<string | null> {
    const found = await this.deps.client.get<StrapiList<{ documentId: string }>>("/api/discussions", {
      filters: { slug: { $eq: slug } },
      fields: ["slug"],
      pagination: { pageSize: 1 },
    })
    return found.data[0]?.documentId ?? null
  }

  private async fetch(filters: StrapiParams, extra: StrapiParams = {}) {
    return this.deps.client.get<StrapiList<StrapiDiscussionEntry>>("/api/discussions", {
      filters,
      populate: SUMMARY_POPULATE,
      ...extra,
    })
  }

  async list(query: ListDiscussionsQuery): Promise<Page<Discussion>> {
    const page = query.page ?? 1
    const pageSize = Math.min(query.pageSize ?? DEFAULT_PAGE_SIZE, MAX_PAGE_SIZE)
    const interests = query.viewer?.interests ?? []
    const filters: StrapiParams = {}
    if (query.categorySlug) filters.category = { slug: { $eq: query.categorySlug } }
    else if (query.tab === "pour-vous" && interests.length > 0) filters.category = { slug: { $in: interests } }
    if (query.tab === "sans-reponse") filters.replies = { id: { $null: true } }
    if (query.search?.trim()) Object.assign(filters, searchFilter(query.search.trim()))

    const sort = query.order
      ? [`createdAt:${query.order === "oldest" ? "asc" : "desc"}`]
      : query.tab === "tendances"
        ? ["views:desc", "createdAt:desc"]
        : query.tab === "recentes" || query.tab === "sans-reponse"
          ? ["createdAt:desc"]
          : ["pinned:desc", "createdAt:desc"]

    const [result, context] = await Promise.all([this.fetch(filters, { sort, pagination: { page, pageSize } }), this.context()])
    const pagination = result.meta?.pagination
    return {
      items: result.data.map((entry) => toDiscussion(entry, context)),
      page: pagination?.page ?? page,
      pageCount: pagination?.pageCount ?? 1,
      total: pagination?.total ?? result.data.length,
    }
  }

  async countUnanswered(categorySlug?: string): Promise<number> {
    const result = await this.deps.client.get<StrapiList<{ id: number }>>("/api/discussions", {
      filters: { replies: { id: { $null: true } }, ...(categorySlug ? { category: { slug: { $eq: categorySlug } } } : {}) },
      fields: ["slug"],
      pagination: { page: 1, pageSize: 1, withCount: true },
    })
    return result.meta?.pagination?.total ?? 0
  }

  async questionStats(): Promise<{ total: number; solved: number }> {
    const count = async (filters: StrapiParams) => {
      const result = await this.deps.client.get<StrapiList<{ id: number }>>("/api/discussions", {
        filters,
        fields: ["slug"],
        pagination: { page: 1, pageSize: 1, withCount: true },
      })
      return result.meta?.pagination?.total ?? 0
    }
    const question: StrapiParams = { type: { $eq: "question" } }
    const [total, solved] = await Promise.all([count(question), count({ ...question, replies: { isBestAnswer: { $eq: true } } })])
    return { total, solved }
  }

  async findById(id: string): Promise<DiscussionDetail | null> {
    const [result, context] = await Promise.all([
      this.deps.client.get<StrapiList<StrapiDiscussionEntry>>("/api/discussions", {
        filters: { slug: { $eq: id } },
        populate: DETAIL_POPULATE,
        pagination: { pageSize: 1 },
      }),
      this.context(),
    ])
    return result.data[0] ? toDetail(result.data[0], context) : null
  }

  async search(text: string): Promise<Discussion[]> {
    const [result, context] = await Promise.all([
      this.fetch(searchFilter(text), { sort: ["createdAt:desc"], pagination: { pageSize: SEARCH_LIMIT } }),
      this.context(),
    ])
    return result.data.map((entry) => toDiscussion(entry, context))
  }

  async listByAuthor(username: string): Promise<Discussion[]> {
    const [result, context] = await Promise.all([
      this.fetch({ author: { username: { $eq: username } } }, { sort: ["createdAt:desc"], pagination: { pageSize: BY_AUTHOR_LIMIT } }),
      this.context(),
    ])
    return result.data.map((entry) => toDiscussion(entry, context))
  }

  async listRepliesBy(username: string): Promise<AuthoredReply[]> {
    const result = await this.deps.client.get<
      StrapiList<StrapiReplyEntry & { discussion?: { slug: string; title: string } | null }>
    >("/api/replies", {
      filters: { author: { username: { $eq: username } } },
      sort: ["createdAt:desc"],
      populate: { discussion: { fields: ["slug", "title"] } },
      pagination: { pageSize: BY_AUTHOR_LIMIT },
    })
    return result.data
      .filter((entry) => entry.discussion)
      .map((entry) => ({
        discussionId: entry.discussion!.slug,
        discussionTitle: entry.discussion!.title,
        content: entry.content ?? "",
        isSolution: entry.isBestAnswer,
      }))
  }

  async featured(kind: "question" | "poll"): Promise<Discussion | null> {
    const [result, context] = await Promise.all([
      this.fetch({ featured: { $eq: kind } }, { sort: ["createdAt:desc"], pagination: { pageSize: 1 } }),
      this.context(),
    ])
    return result.data[0] ? toDiscussion(result.data[0], context) : null
  }

  async similarCandidates(): Promise<SimilarCandidate[]> {
    const result = await this.deps.client.get<StrapiList<StrapiDiscussionEntry>>("/api/discussions", {
      fields: ["title", "slug"],
      populate: { replies: { fields: ["isBestAnswer"] } },
      sort: ["createdAt:desc"],
      pagination: { pageSize: MAX_PAGE_SIZE },
    })
    return result.data.map((entry) => ({
      id: entry.slug,
      title: entry.title,
      repliesCount: entry.replies?.length ?? 0,
      solved: (entry.replies ?? []).some((reply) => reply.isBestAnswer),
    }))
  }

  async create(_author: User, input: NewDiscussionInput): Promise<Published<DiscussionDetail>> {
    const token = await this.memberToken()
    const found = await this.deps.client.get<StrapiList<{ documentId: string }>>("/api/categories", {
      filters: { slug: { $eq: input.categorySlug } },
      fields: ["slug"],
      pagination: { pageSize: 1 },
    })
    const categoryId = found.data[0]?.documentId
    if (!categoryId) throw new AppError("validation", { category: "category.required" })

    const options = (input.options ?? []).map((option) => option.trim()).filter(Boolean)
    const created = await this.deps.client.send<StrapiOne<{ slug: string }> & CreatedMeta>(
      "POST",
      "/api/discussions",
      {
        data: {
          title: input.title,
          content: input.content,
          type: input.type,
          category: categoryId,
          ...(input.article ? { article: input.article } : {}),
          ...(input.type === "poll" ? { pollOptions: options } : {}),
        },
      },
      { token }
    )
    const stored = await this.findById(created.data.slug)
    if (!stored) throw new AppError("unavailable")
    return { item: stored, ...publishedMeta(created) }
  }

  async addReply(discussionId: string, content: string): Promise<Published<Reply> | null> {
    const token = await this.memberToken()
    const documentId = await this.documentIdOf(discussionId)
    if (!documentId) return null
    const created = await this.deps.client.send<StrapiOne<StrapiReplyEntry> & CreatedMeta>(
      "POST",
      "/api/replies",
      { data: { content, discussion: documentId } },
      { token }
    )
    return { item: toReply(created.data, await this.context()), ...publishedMeta(created) }
  }

  async toggleLike(discussionId: string, replyId: string | null): Promise<UsefulResult | null> {
    const token = await this.memberToken()
    try {
      if (replyId) return await this.deps.client.send<UsefulResult>("POST", `/api/replies/${replyId}/useful`, undefined, { token })
      const documentId = await this.documentIdOf(discussionId)
      if (!documentId) return null
      return await this.deps.client.send<UsefulResult>("POST", `/api/discussions/${documentId}/useful`, undefined, { token })
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async toggleFollow(discussionId: string): Promise<boolean | null> {
    const token = await this.memberToken()
    try {
      const documentId = await this.documentIdOf(discussionId)
      if (!documentId) return null
      const result = await this.deps.client.send<{ followed: boolean }>("POST", `/api/discussions/${documentId}/follow`, undefined, { token })
      return result.followed
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async vote(discussionId: string, optionIndex: number): Promise<VoteResult | null> {
    const token = await this.memberToken()
    try {
      const documentId = await this.documentIdOf(discussionId)
      if (!documentId) return null
      const result = await this.deps.client.send<VoteResult>("POST", `/api/discussions/${documentId}/vote`, { option: optionIndex }, { token })
      return { first: result.first, effects: result.effects ?? [] }
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async toggleSolution(_discussionId: string, replyId: string): Promise<SolutionResult | null> {
    const token = await this.memberToken()
    try {
      const current = await this.deps.client.get<StrapiOne<StrapiReplyEntry>>(`/api/replies/${replyId}`, { fields: ["isBestAnswer"] })
      const next = !current.data.isBestAnswer
      const updated = await this.deps.client.send<{ meta?: { answerer?: string | null; points?: number } }>(
        "PUT",
        `/api/replies/${replyId}`,
        { data: { isBestAnswer: next } },
        { token }
      )
      return { solutionId: next ? replyId : null, answerer: updated.meta?.answerer ?? null, points: updated.meta?.points ?? 0 }
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async toggleVerified(): Promise<boolean | null> {
    return null
  }
}
