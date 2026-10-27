import { describe, expect, it, vi } from "vitest"

import type { Category } from "@/modules/categories/domain/category"
import type { StrapiClient } from "@/lib/strapi-client"
import { defaultStats, type User } from "@/modules/users/domain/user"
import type { DiscussionRepository } from "../application/discussion.repository"
import { StrapiDiscussionRepository, type Viewer } from "./strapi-discussion.repository"
import type { StrapiDiscussionEntry } from "./strapi-types"

const member = (username: string, patch: Partial<User> = {}): User => ({
  username,
  name: username,
  color: "var(--av-1)",
  role: "member",
  subscriber: false,
  points: 0,
  month: 0,
  bio: "",
  interests: [],
  badges: [],
  stats: defaultStats(0, 0),
  ...patch,
})

const category: Category = { slug: "bourse", name: "Bourse", description: "", icon: "candles", color: "#007aff", topicsCount: 0, repliesCount: 0, siteSection: null }

const entry = (patch: Partial<StrapiDiscussionEntry> = {}): StrapiDiscussionEntry => ({
  id: 1,
  documentId: "d1",
  slug: "ma-discussion",
  title: "Ma discussion de test",
  content: "Contenu",
  type: "question",
  article: null,
  pinned: false,
  featured: null,
  views: 3,
  usefulBase: 0,
  pollOptions: null,
  pollVotes: null,
  createdAt: "2026-10-23T08:00:00.000Z",
  author: { id: 1, username: "alice" },
  category: { slug: "bourse", name: "Bourse" },
  usefulBy: [],
  followedBy: [],
  replies: [],
  ...patch,
})

const camille: Viewer = { id: 7, username: "Camille_B", token: "member-token" }

type Handler = (path: string, query: Record<string, unknown>, auth?: { token?: string }) => unknown

function setup({ get = () => ({ data: [] }), send = () => ({}), viewer = camille as Viewer | null }: { get?: Handler; send?: Handler; viewer?: Viewer | null } = {}) {
  const client = {
    get: vi.fn(async (path: string, query: Record<string, unknown> = {}, auth?: { token?: string }) => get(path, query, auth)),
    send: vi.fn(async (_method: string, path: string, body?: unknown, auth?: { token?: string }) => send(path, (body ?? {}) as Record<string, unknown>, auth)),
  }
  const repository: DiscussionRepository = new StrapiDiscussionRepository({
    client: client as unknown as StrapiClient,
    users: { list: async () => [member("alice"), member("Camille_B", { interests: ["bourse"] })] },
    viewer: async () => viewer,
    categories: async () => [category],
  })
  return { repository, client }
}

const page = (data: unknown[], pagination = { page: 1, pageSize: 50, pageCount: 1, total: data.length }) => ({ data, meta: { pagination } })
type RecordedQuery = { populate: Record<string, unknown> } & Record<string, unknown>
const lastGet = (client: { get: { mock: { calls: unknown[][] } } }) => {
  const [path, query] = client.get.mock.calls.at(-1) as [string, RecordedQuery]
  return { path, query }
}

describe("StrapiDiscussionRepository", () => {
  describe("list", () => {
    it("asks Strapi for one sorted page with the relations in the same request", async () => {
      const { repository, client } = setup({ get: () => page([entry()], { page: 1, pageSize: 50, pageCount: 3, total: 120 }) })
      const result = await repository.list({})
      const { path, query } = lastGet(client)
      expect(path).toBe("/api/discussions")
      expect(query.pagination).toEqual({ page: 1, pageSize: 50 })
      expect(query.sort).toEqual(["pinned:desc", "createdAt:desc"])
      expect(query.populate).toMatchObject({ category: expect.anything(), author: expect.anything(), replies: expect.anything() })
      expect(result).toMatchObject({ page: 1, pageCount: 3, total: 120 })
      expect(result.items[0].id).toBe("ma-discussion")
    })

    it("paginates on request", async () => {
      const { repository, client } = setup()
      await repository.list({ page: 3, pageSize: 10 })
      expect(lastGet(client).query.pagination).toEqual({ page: 3, pageSize: 10 })
    })

    it("filters by category in Strapi", async () => {
      const { repository, client } = setup()
      await repository.list({ categorySlug: "impots" })
      expect(lastGet(client).query.filters).toMatchObject({ category: { slug: { $eq: "impots" } } })
    })

    it("sorts the recent tab by date only", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "recentes" })
      expect(lastGet(client).query.sort).toEqual(["createdAt:desc"])
    })

    it("lets the reader sort by publication date in Strapi, oldest or newest first, whatever the tab", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "tendances", order: "oldest" })
      expect(lastGet(client).query.sort).toEqual(["createdAt:asc"])
      await repository.list({ tab: "pour-vous", order: "newest" })
      expect(lastGet(client).query.sort).toEqual(["createdAt:desc"])
    })

    it("asks Strapi for the requested page and page size", async () => {
      const { repository, client } = setup({ get: () => page([], { page: 2, pageSize: 10, pageCount: 3, total: 25 }) })
      const result = await repository.list({ tab: "recentes", page: 2, pageSize: 10 })
      expect(lastGet(client).query.pagination).toEqual({ page: 2, pageSize: 10 })
      expect(result).toMatchObject({ page: 2, pageCount: 3, total: 25 })
    })

    it("sorts the trending tab by views", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "tendances" })
      expect(lastGet(client).query.sort).toEqual(["views:desc", "createdAt:desc"])
    })

    it("lists unanswered discussions with a filter on the replies relation", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "sans-reponse" })
      expect(lastGet(client).query.filters).toMatchObject({ replies: { id: { $null: true } } })
    })

    it("builds the For you tab from the viewer's interests", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "pour-vous", viewer: member("Camille_B", { interests: ["bourse", "retraite"] }) })
      expect(lastGet(client).query.filters).toMatchObject({ category: { slug: { $in: ["bourse", "retraite"] } } })
    })

    it("shows every space in the For you tab when the viewer has no interests", async () => {
      const { repository, client } = setup()
      await repository.list({ tab: "pour-vous", viewer: member("x") })
      expect(lastGet(client).query.filters ?? {}).not.toHaveProperty("category")
    })

    it("searches the title and the content", async () => {
      const { repository, client } = setup()
      await repository.list({ search: "pea" })
      expect(lastGet(client).query.filters).toMatchObject({
        $or: [{ title: { $containsi: "pea" } }, { content: { $containsi: "pea" } }],
      })
    })

    it("marks what the viewer already voted on", async () => {
      const { repository } = setup({ get: () => page([entry({ usefulBy: [{ id: 7 }] })]) })
      expect((await repository.list({})).items[0].liked).toBe(true)
    })
  })

  describe("countUnanswered", () => {
    it("reads the total from Strapi's pagination, scoped to a space when asked", async () => {
      const { repository, client } = setup({ get: () => page([], { page: 1, pageSize: 1, pageCount: 4, total: 4 }) })
      expect(await repository.countUnanswered("bourse")).toBe(4)
      const { query } = lastGet(client)
      expect(query.filters).toMatchObject({ replies: { id: { $null: true } }, category: { slug: { $eq: "bourse" } } })
      expect(query.pagination).toMatchObject({ pageSize: 1 })
    })
  })

  describe("findById", () => {
    it("finds the discussion by its slug with its replies and their authors", async () => {
      const { repository, client } = setup({ get: () => page([entry({ replies: [] })]) })
      const found = await repository.findById("ma-discussion")
      const { query } = lastGet(client)
      expect(query.filters).toEqual({ slug: { $eq: "ma-discussion" } })
      expect(query.populate.replies).toMatchObject({ sort: ["createdAt:asc"] })
      expect(found?.id).toBe("ma-discussion")
    })

    it("returns null for an unknown address", async () => {
      const { repository } = setup({ get: () => page([]) })
      expect(await repository.findById("inconnue")).toBeNull()
    })
  })

  describe("simple reads", () => {
    it("lists a member's discussions by author", async () => {
      const { repository, client } = setup({ get: () => page([entry()]) })
      await repository.listByAuthor("alice")
      expect(lastGet(client).query.filters).toEqual({ author: { username: { $eq: "alice" } } })
    })

    it("lists a member's replies with the discussion they belong to", async () => {
      const { repository, client } = setup({
        get: () =>
          page([
            { documentId: "r1", content: "Ma réponse", isBestAnswer: true, createdAt: "2026-10-23T09:00:00.000Z", discussion: { slug: "sujet", title: "Un sujet" } },
          ]),
      })
      expect(await repository.listRepliesBy("alice")).toEqual([
        { discussionId: "sujet", discussionTitle: "Un sujet", content: "Ma réponse", isSolution: true },
      ])
      expect(lastGet(client).path).toBe("/api/replies")
    })

    it("finds the featured discussion of a kind", async () => {
      const { repository, client } = setup({ get: () => page([entry({ featured: "poll" })]) })
      expect((await repository.featured("poll"))?.featured).toBe("poll")
      expect(lastGet(client).query.filters).toEqual({ featured: { $eq: "poll" } })
    })

    it("returns null when nothing is featured", async () => {
      const { repository } = setup({ get: () => page([]) })
      expect(await repository.featured("question")).toBeNull()
    })

    it("builds the candidates for similar-discussion suggestions", async () => {
      const { repository } = setup({
        get: () => page([entry({ replies: [{ id: 1, documentId: "r", isBestAnswer: true, verified: false, usefulBase: 0, createdAt: "2026-10-23T09:00:00.000Z" }] })]),
      })
      expect(await repository.similarCandidates()).toEqual([{ id: "ma-discussion", title: "Ma discussion de test", repliesCount: 1, solved: true }])
    })

    it("searches by text", async () => {
      const { repository, client } = setup({ get: () => page([entry()]) })
      expect(await repository.search("pea")).toHaveLength(1)
      expect(lastGet(client).query.filters).toMatchObject({ $or: expect.any(Array) })
    })
  })

  describe("create", () => {
    const input = { title: "Comment placer 10 000 euros ?", content: "Bonjour", type: "question" as const, categorySlug: "bourse" }

    const created = (extra: Record<string, unknown> = {}) =>
      setup({
        get: (path) => (path === "/api/categories" ? page([{ documentId: "cat1", slug: "bourse" }]) : page([entry({ slug: "comment-placer-10-000-euros", ...extra })])),
        send: () => ({ data: { slug: "comment-placer-10-000-euros" } }),
      })

    it("posts with the member's own token, never the server token", async () => {
      const { repository, client } = created()
      await repository.create(member("Camille_B"), input)
      const [method, path, body, auth] = client.send.mock.calls[0] as [string, string, { data: Record<string, unknown> }, { token: string }]
      expect([method, path]).toEqual(["POST", "/api/discussions"])
      expect(auth.token).toBe("member-token")
      expect(body.data).toMatchObject({ title: input.title, content: "Bonjour", type: "question", category: "cat1" })
    })

    it("does not send an author: Strapi decides it", async () => {
      const { repository, client } = created()
      await repository.create(member("Camille_B"), input)
      const body = client.send.mock.calls[0][2] as { data: Record<string, unknown> }
      expect(body.data).not.toHaveProperty("author")
      expect(body.data).not.toHaveProperty("slug")
    })

    it("sends the poll options and the article", async () => {
      const { repository, client } = created()
      await repository.create(member("Camille_B"), { ...input, type: "poll", content: "", options: [" Oui ", "Non", ""], article: "Un article" })
      const body = client.send.mock.calls[0][2] as { data: Record<string, unknown> }
      expect(body.data).toMatchObject({ type: "poll", pollOptions: ["Oui", "Non"], article: "Un article" })
    })

    it("returns the stored discussion with the address Strapi generated", async () => {
      const { repository } = created()
      expect((await repository.create(member("Camille_B"), input)).item.id).toBe("comment-placer-10-000-euros")
    })

    it("refuses when nobody is signed in", async () => {
      const { repository, client } = setup({ viewer: null })
      await expect(repository.create(member("x"), input)).rejects.toMatchObject({ code: "unauthenticated" })
      expect(client.send).not.toHaveBeenCalled()
    })

    it("refuses an unknown space", async () => {
      const { repository } = setup({ get: () => page([]) })
      await expect(repository.create(member("Camille_B"), input)).rejects.toMatchObject({ code: "validation" })
    })
  })

  describe("addReply", () => {
    const withDiscussion = () =>
      setup({
        get: () => page([{ documentId: "d1" }]),
        send: () => ({ data: { id: 9, documentId: "r9", content: "Merci", isBestAnswer: false, verified: false, usefulBase: 0, createdAt: "2026-10-23T10:00:00.000Z", author: { id: 7, username: "Camille_B" }, usefulBy: [] } }),
      })

    it("posts the reply to the discussion found by its slug, with the member's token", async () => {
      const { repository, client } = withDiscussion()
      const reply = await repository.addReply("ma-discussion", "Merci")
      const [, path, body, auth] = client.send.mock.calls[0] as [string, string, { data: Record<string, unknown> }, { token: string }]
      expect(path).toBe("/api/replies")
      expect(body.data).toEqual({ content: "Merci", discussion: "d1" })
      expect(auth.token).toBe("member-token")
      expect(reply).toMatchObject({ item: { id: "r9", content: "Merci" }, effects: [], mentioned: [] })
    })

    it("returns null when the discussion does not exist", async () => {
      const { repository, client } = setup({ get: () => page([]) })
      expect(await repository.addReply("inconnue", "Merci")).toBeNull()
      expect(client.send).not.toHaveBeenCalled()
    })
  })

  describe("member actions", () => {
    it("marks a discussion useful through Strapi", async () => {
      const { repository, client } = setup({
        get: () => page([{ documentId: "d1" }]),
        send: () => ({ liked: true, likes: 3, rewardedAuthor: "Alice" }),
      })
      expect(await repository.toggleLike("ma-discussion", null)).toEqual({ liked: true, likes: 3, rewardedAuthor: "Alice" })
      expect(client.send.mock.calls[0].slice(0, 2)).toEqual(["POST", "/api/discussions/d1/useful"])
      expect((client.send.mock.calls[0][3] as { token: string }).token).toBe("member-token")
    })

    it("marks a reply useful through Strapi", async () => {
      const { repository, client } = setup({ send: () => ({ liked: false, likes: 0, rewardedAuthor: null }) })
      await repository.toggleLike("ma-discussion", "r1")
      expect(client.send.mock.calls[0].slice(0, 2)).toEqual(["POST", "/api/replies/r1/useful"])
    })

    it("returns null when the target is gone", async () => {
      const { repository } = setup({
        get: () => page([{ documentId: "d1" }]),
        send: () => {
          throw Object.assign(new Error("x"), { code: "not-found" })
        },
      })
      expect(await repository.toggleLike("ma-discussion", null)).toBeNull()
    })

    it("follows and unfollows", async () => {
      const { repository, client } = setup({ get: () => page([{ documentId: "d1" }]), send: () => ({ followed: true }) })
      expect(await repository.toggleFollow("ma-discussion")).toBe(true)
      expect(client.send.mock.calls[0][1]).toBe("/api/discussions/d1/follow")
    })

    it("votes in a poll", async () => {
      const { repository, client } = setup({ get: () => page([{ documentId: "d1" }]), send: () => ({ first: true, counts: [1, 0], effects: [{ kind: "points", points: 1, reason: "Merci pour votre vote", total: 2 }] }) })
      expect(await repository.vote("ma-discussion", 0)).toEqual({ first: true, effects: [{ kind: "points", points: 1, reason: "Merci pour votre vote", total: 2 }] })
      expect(client.send.mock.calls[0][1]).toBe("/api/discussions/d1/vote")
      expect(client.send.mock.calls[0][2]).toEqual({ option: 0 })
    })

    it("chooses a reply as best answer when it is not yet", async () => {
      const { repository, client } = setup({
        get: () => ({ data: { documentId: "r1", isBestAnswer: false, author: { username: "bob" } } }),
        send: () => ({ data: { isBestAnswer: true }, meta: { answerer: "Bob", points: 20 } }),
      })
      expect(await repository.toggleSolution("ma-discussion", "r1")).toEqual({ solutionId: "r1", answerer: "Bob", points: 20 })
      expect(client.send.mock.calls[0].slice(0, 3)).toEqual(["PUT", "/api/replies/r1", { data: { isBestAnswer: true } }])
    })

    it("removes the best answer when the reply already is one", async () => {
      const { repository } = setup({
        get: () => ({ data: { documentId: "r1", isBestAnswer: true, author: { username: "bob" } } }),
        send: () => ({ data: { isBestAnswer: false }, meta: { answerer: null, points: 0 } }),
      })
      expect(await repository.toggleSolution("ma-discussion", "r1")).toEqual({ solutionId: null, answerer: null, points: 0 })
    })

    it("cannot validate a reply on behalf of the editorial team", async () => {
      const { repository } = setup()
      expect(await repository.toggleVerified("ma-discussion", "r1")).toBeNull()
    })

    it("refuses member actions when nobody is signed in", async () => {
      const { repository } = setup({ viewer: null })
      await expect(repository.toggleLike("ma-discussion", "r1")).rejects.toMatchObject({ code: "unauthenticated" })
    })
  })
})
