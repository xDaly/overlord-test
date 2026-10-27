import { AppError } from "@/lib/errors"
import type { StrapiClient, StrapiList, StrapiOne } from "@/lib/strapi-client"
import type { StrapiParams } from "@/lib/strapi-query"
import { unknownCategory, type Category } from "@/modules/categories/domain/category"
import type { Published, UsefulResult } from "@/modules/community/application/deps"
import type { Viewer } from "@/modules/discussions/infrastructure/strapi-discussion.repository"
import type { UserRepository } from "@/modules/users/application/user.repository"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import { unknownUser } from "@/modules/users/infrastructure/strapi-member"
import type { BlogRepository } from "../application/blog.repository"
import type { BlogComment, BlogPost, BlogPostDetail, NewBlogInput } from "../domain/blog"

type Ref = { id: number }
type Author = { username: string } | null

export type StrapiCommentEntry = {
  documentId: string
  content: string
  createdAt: string
  usefulBase: number
  author?: Author
  usefulBy?: Ref[]
}

export type StrapiBlogEntry = {
  documentId: string
  title: string
  content: string
  createdAt: string
  views: number
  usefulBase: number
  author?: Author
  category?: { slug: string; name: string } | null
  usefulBy?: Ref[]
  comments?: (Partial<StrapiCommentEntry> & { documentId: string })[]
}

type CreatedMeta = { meta?: { effects?: Effect[]; mentioned?: { name: string }[] } }

type Deps = {
  client: StrapiClient
  users: Pick<UserRepository, "list">
  viewer: () => Promise<Viewer | null>
  categories: () => Promise<Category[]>
}

const MAX_POSTS = 100
const MEMBER = { fields: ["username"] }
const IDS = { fields: ["id"] }

const SUMMARY_POPULATE: StrapiParams = {
  author: MEMBER,
  category: { fields: ["slug", "name"] },
  usefulBy: IDS,
  comments: { fields: ["documentId"] },
}

const DETAIL_POPULATE: StrapiParams = {
  ...SUMMARY_POPULATE,
  comments: { sort: ["createdAt:asc"], populate: { author: MEMBER, usefulBy: IDS } },
}

const isNotFound = (error: unknown) => (error as { code?: string } | null)?.code === "not-found"

export class StrapiBlogRepository implements BlogRepository {
  constructor(private readonly deps: Deps) {}

  private async context() {
    const [viewer, users, categories] = await Promise.all([this.deps.viewer(), this.deps.users.list(), this.deps.categories()])
    const byName = new Map(users.map((user) => [user.username, user]))
    const bySlug = new Map(categories.map((category) => [category.slug, category]))
    const viewerId = viewer?.id ?? null
    return {
      liked: (entry: { usefulBy?: Ref[] }) => viewerId !== null && (entry.usefulBy ?? []).some((member) => member.id === viewerId),
      user: (author: Author | undefined): User => byName.get(author?.username ?? "") ?? unknownUser(author?.username ?? ""),
      category: (entry: StrapiBlogEntry["category"]) =>
        entry ? (bySlug.get(entry.slug) ?? unknownCategory(entry.slug, entry.name)) : null,
    }
  }

  private toComment(entry: StrapiCommentEntry, context: Awaited<ReturnType<StrapiBlogRepository["context"]>>): BlogComment {
    return {
      id: entry.documentId,
      content: entry.content,
      createdAt: entry.createdAt,
      likes: entry.usefulBase + (entry.usefulBy?.length ?? 0),
      liked: context.liked(entry),
      author: context.user(entry.author),
    }
  }

  private toPost(entry: StrapiBlogEntry, context: Awaited<ReturnType<StrapiBlogRepository["context"]>>): BlogPost {
    return {
      id: entry.documentId,
      title: entry.title,
      content: entry.content,
      category: context.category(entry.category),
      createdAt: entry.createdAt,
      likes: entry.usefulBase + (entry.usefulBy?.length ?? 0),
      liked: context.liked(entry),
      views: entry.views,
      author: context.user(entry.author),
      commentsCount: entry.comments?.length ?? 0,
    }
  }

  private async memberToken(): Promise<string> {
    const viewer = await this.deps.viewer()
    if (!viewer) throw new AppError("unauthenticated")
    return viewer.token
  }

  private async fetchList(filters: StrapiParams): Promise<BlogPost[]> {
    const [result, context] = await Promise.all([
      this.deps.client.get<StrapiList<StrapiBlogEntry>>("/api/blog-posts", {
        filters,
        populate: SUMMARY_POPULATE,
        sort: ["createdAt:desc"],
        pagination: { pageSize: MAX_POSTS },
      }),
      this.context(),
    ])
    return result.data.map((entry) => this.toPost(entry, context))
  }

  list(): Promise<BlogPost[]> {
    return this.fetchList({})
  }

  listByAuthor(username: string): Promise<BlogPost[]> {
    return this.fetchList({ author: { username: { $eq: username } } })
  }

  async findById(id: string): Promise<BlogPostDetail | null> {
    try {
      const [result, context] = await Promise.all([
        this.deps.client.get<StrapiOne<StrapiBlogEntry>>(`/api/blog-posts/${encodeURIComponent(id)}`, { populate: DETAIL_POPULATE }),
        this.context(),
      ])
      const comments = (result.data.comments ?? []) as StrapiCommentEntry[]
      return { ...this.toPost(result.data, context), comments: comments.map((entry) => this.toComment(entry, context)) }
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async create(input: NewBlogInput): Promise<Published<BlogPostDetail>> {
    const token = await this.memberToken()
    let category: string | null = null
    if (input.categorySlug) {
      const found = await this.deps.client.get<StrapiList<{ documentId: string }>>("/api/categories", {
        filters: { slug: { $eq: input.categorySlug } },
        fields: ["slug"],
        pagination: { pageSize: 1 },
      })
      category = found.data[0]?.documentId ?? null
      if (!category) throw new AppError("validation", { category: "category.required" })
    }
    const created = await this.deps.client.send<StrapiOne<{ documentId: string }> & CreatedMeta>(
      "POST",
      "/api/blog-posts",
      { data: { title: input.title, content: input.content, category } },
      { token }
    )
    const stored = await this.findById(created.data.documentId)
    if (!stored) throw new AppError("unavailable")
    return { item: stored, effects: created.meta?.effects ?? [], mentioned: (created.meta?.mentioned ?? []).map((member) => member.name) }
  }

  async addComment(blogId: string, content: string): Promise<Published<BlogComment> | null> {
    const token = await this.memberToken()
    if (!(await this.findById(blogId))) return null
    const created = await this.deps.client.send<StrapiOne<StrapiCommentEntry> & CreatedMeta>(
      "POST",
      "/api/blog-comments",
      { data: { content, post: blogId } },
      { token }
    )
    return {
      item: this.toComment(created.data, await this.context()),
      effects: created.meta?.effects ?? [],
      mentioned: (created.meta?.mentioned ?? []).map((member) => member.name),
    }
  }

  async toggleLike(blogId: string, commentId: string | null): Promise<UsefulResult | null> {
    const token = await this.memberToken()
    const path = commentId ? `/api/blog-comments/${commentId}/useful` : `/api/blog-posts/${blogId}/useful`
    try {
      return await this.deps.client.send<UsefulResult>("POST", path, undefined, { token })
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }
}
