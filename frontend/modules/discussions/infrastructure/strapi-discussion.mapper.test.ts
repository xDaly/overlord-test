import { describe, expect, it } from "vitest"

import type { Category } from "@/modules/categories/domain/category"
import { defaultStats, type User } from "@/modules/users/domain/user"
import { toDetail, toDiscussion, toReply, type MapContext } from "./strapi-discussion.mapper"
import type { StrapiDiscussionEntry, StrapiReplyEntry } from "./strapi-types"

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

const users: Record<string, User> = {
  alice: member("alice"),
  bob: member("bob"),
  carol: member("carol"),
  expert: member("expert", { expertTitle: "Notaire" }),
  redaction: member("redaction", { role: "redaction" }),
}

const category: Category = { slug: "bourse", name: "Bourse & actions", description: "", icon: "candles", color: "#007aff", topicsCount: 0, repliesCount: 0, siteSection: null }

const context = (viewerId: number | null = null): MapContext => ({
  viewerId,
  user: (username) => users[username] ?? member(username),
  category: () => category,
})

const reply = (patch: Partial<StrapiReplyEntry> = {}): StrapiReplyEntry => ({
  id: 1,
  documentId: "r1",
  content: "Une réponse",
  isBestAnswer: false,
  verified: false,
  usefulBase: 0,
  createdAt: "2026-10-23T10:00:00.000Z",
  author: { id: 2, username: "bob" },
  usefulBy: [],
  ...patch,
})

const entry = (patch: Partial<StrapiDiscussionEntry> = {}): StrapiDiscussionEntry => ({
  id: 10,
  documentId: "d1",
  slug: "comment-placer-10-000-euros",
  title: "Comment placer 10 000 euros ?",
  content: "Bonjour",
  type: "question",
  article: null,
  pinned: false,
  featured: null,
  views: 120,
  usefulBase: 0,
  pollOptions: null,
  pollVotes: null,
  createdAt: "2026-10-23T08:00:00.000Z",
  author: { id: 1, username: "alice" },
  category: { slug: "bourse", name: "Bourse & actions" },
  usefulBy: [],
  followedBy: [],
  replies: [],
  ...patch,
})

describe("toReply", () => {
  it("adds the seeded baseline to the real votes", () => {
    const mapped = toReply(reply({ usefulBase: 5, usefulBy: [{ id: 1 }, { id: 3 }] }), context())
    expect(mapped.likes).toBe(7)
  })

  it("tells whether the viewer already marked it useful", () => {
    expect(toReply(reply({ usefulBy: [{ id: 9 }] }), context(9)).liked).toBe(true)
    expect(toReply(reply({ usefulBy: [{ id: 9 }] }), context(4)).liked).toBe(false)
    expect(toReply(reply({ usefulBy: [{ id: 9 }] }), context(null)).liked).toBe(false)
  })

  it("maps the identifier, text, date, author and validation flag", () => {
    const mapped = toReply(reply({ verified: true }), context())
    expect(mapped).toMatchObject({ id: "r1", content: "Une réponse", createdAt: "2026-10-23T10:00:00.000Z", verified: true })
    expect(mapped.author.username).toBe("bob")
  })
})

describe("toDiscussion", () => {
  it("uses the slug as identifier so the address stays readable", () => {
    expect(toDiscussion(entry(), context()).id).toBe("comment-placer-10-000-euros")
  })

  it("maps the basic fields", () => {
    const mapped = toDiscussion(entry({ pinned: true, featured: "question", article: "Un article", views: 55 }), context())
    expect(mapped).toMatchObject({
      title: "Comment placer 10 000 euros ?",
      content: "Bonjour",
      type: "question",
      pinned: true,
      featured: "question",
      article: "Un article",
      views: 55,
      createdAt: "2026-10-23T08:00:00.000Z",
    })
    expect(mapped.author.username).toBe("alice")
    expect(mapped.category.slug).toBe("bourse")
  })

  it("counts baseline and real votes, and knows the viewer's vote and follow", () => {
    const mapped = toDiscussion(entry({ usefulBase: 10, usefulBy: [{ id: 7 }], followedBy: [{ id: 7 }, { id: 8 }] }), context(7))
    expect(mapped).toMatchObject({ likes: 11, liked: true, followed: true })
    expect(toDiscussion(entry({ usefulBy: [{ id: 7 }] }), context(8))).toMatchObject({ liked: false, followed: false })
  })

  it("counts replies and reports the last activity", () => {
    const mapped = toDiscussion(
      entry({
        replies: [reply({ createdAt: "2026-10-23T09:00:00.000Z" }), reply({ id: 2, documentId: "r2", createdAt: "2026-10-23T11:30:00.000Z" })],
      }),
      context()
    )
    expect(mapped.repliesCount).toBe(2)
    expect(mapped.lastActivityAt).toBe("2026-10-23T11:30:00.000Z")
    expect(toDiscussion(entry(), context()).lastActivityAt).toBe("2026-10-23T08:00:00.000Z")
  })

  it("lists each participant once, keeping the four most recent", () => {
    const authors = ["alice", "bob", "carol", "expert", "redaction", "bob"]
    const replies = authors.map((username, index) => reply({ id: index, documentId: `r${index}`, author: { id: index, username } }))
    const names = toDiscussion(entry({ replies }), context()).participants.map((user) => user.username)
    expect(names).toEqual(["carol", "expert", "redaction", "bob"])
  })

  it("exposes the best answer", () => {
    const mapped = toDiscussion(entry({ replies: [reply(), reply({ id: 2, documentId: "r2", isBestAnswer: true })] }), context())
    expect(mapped.solutionId).toBe("r2")
    expect(toDiscussion(entry({ replies: [reply()] }), context()).solutionId).toBeNull()
  })

  it("builds poll options with their counts and the viewer's vote", () => {
    const poll = entry({
      type: "poll",
      pollOptions: ["Actions", "Obligations"],
      pollVotes: { counts: [214, 3], voters: { "7": 1 } },
    })
    const mapped = toDiscussion(poll, context(7))
    expect(mapped.options).toEqual([
      { label: "Actions", votes: 214 },
      { label: "Obligations", votes: 3 },
    ])
    expect(mapped.myVote).toBe(1)
    expect(toDiscussion(poll, context(8)).myVote).toBeNull()
    expect(toDiscussion(entry(), context()).options).toBeNull()
  })

  it("sums the useful votes of the discussion and its replies", () => {
    const mapped = toDiscussion(
      entry({ usefulBase: 4, usefulBy: [{ id: 1 }], replies: [reply({ usefulBase: 3, usefulBy: [{ id: 2 }] })] }),
      context()
    )
    expect(mapped.usefulTotal).toBe(5 + 4)
  })

  it("derives the indexing input from the best answer and the expert participants", () => {
    const base = entry({ replies: [reply({ author: { id: 5, username: "expert" }, isBestAnswer: true, verified: true })] })
    expect(toDiscussion(base, context()).seo).toMatchObject({
      categorySlug: "bourse",
      repliesCount: 1,
      solutionVerified: true,
      hasExpertParticipant: true,
      expertIsRedaction: false,
    })
    expect(toDiscussion(entry({ replies: [reply()] }), context()).seo).toMatchObject({
      solutionVerified: null,
      hasExpertParticipant: false,
    })
    expect(toDiscussion(entry({ author: { id: 6, username: "redaction" } }), context()).seo).toMatchObject({
      hasExpertParticipant: true,
      expertIsRedaction: true,
    })
  })

  it("keeps a placeholder author when the account was deleted", () => {
    expect(toDiscussion(entry({ author: null }), context()).author.username).toBe("")
  })
})

describe("toDetail", () => {
  it("returns the replies in order with the summary", () => {
    const detail = toDetail(entry({ replies: [reply(), reply({ id: 2, documentId: "r2" })] }), context())
    expect(detail.replies.map((r) => r.id)).toEqual(["r1", "r2"])
    expect(detail.repliesCount).toBe(2)
  })
})
