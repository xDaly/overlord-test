import { describe, expect, it } from "vitest"

import { findSimilar, hotScore, selectFeed, type FeedItem } from "./feed"

const NOW = new Date("2026-10-23T12:00:00Z")
const hoursAgo = (h: number) => new Date(NOW.getTime() - h * 3_600_000).toISOString()

const item = (over: Partial<FeedItem> & { id: string }): FeedItem => ({
  title: over.id,
  type: "question",
  categorySlug: "bourse",
  authorUsername: "someone",
  createdAt: hoursAgo(10),
  lastActivityAt: hoursAgo(10),
  likes: 0,
  views: 0,
  pinned: false,
  featured: false,
  repliesCount: 0,
  pollVotes: 0,
  solved: false,
  ...over,
})

describe("hotScore", () => {
  it("ranks an active recent discussion above a stale one", () => {
    const hot = item({ id: "hot", repliesCount: 5, likes: 20, createdAt: hoursAgo(5), lastActivityAt: hoursAgo(1) })
    const stale = item({ id: "stale", repliesCount: 5, likes: 20, createdAt: hoursAgo(200), lastActivityAt: hoursAgo(190) })
    expect(hotScore(hot, NOW)).toBeGreaterThan(hotScore(stale, NOW))
  })

  it("counts poll votes", () => {
    const quiet = item({ id: "a", type: "poll" })
    const voted = item({ id: "b", type: "poll", pollVotes: 400 })
    expect(hotScore(voted, NOW)).toBeGreaterThan(hotScore(quiet, NOW))
  })
})

describe("selectFeed", () => {
  const items = [
    item({ id: "old", createdAt: hoursAgo(100), repliesCount: 2 }),
    item({ id: "new", createdAt: hoursAgo(1) }),
    item({ id: "pin", createdAt: hoursAgo(200), pinned: true, repliesCount: 1 }),
    item({ id: "poll", type: "poll", createdAt: hoursAgo(3) }),
    item({ id: "mine", categorySlug: "cafe", authorUsername: "me", createdAt: hoursAgo(20) }),
  ]
  const ids = (list: FeedItem[]) => list.map((entry) => entry.id)

  it("sorts 'recentes' by date and keeps pinned first", () => {
    expect(ids(selectFeed(items, { tab: "recentes" }, NOW))).toEqual(["pin", "new", "poll", "mine", "old"])
  })

  it("lists only unanswered non-poll discussions in 'sans-reponse', newest first", () => {
    expect(ids(selectFeed(items, { tab: "sans-reponse" }, NOW))).toEqual(["new", "mine"])
  })

  it("hides pinned discussions for a logged member outside spaces", () => {
    const list = selectFeed(items, { tab: "tendances", viewer: "me" }, NOW)
    expect(ids(list)).not.toContain("pin")
  })

  it("keeps pinned discussions first inside a space", () => {
    expect(ids(selectFeed(items, { tab: "tendances", categorySlug: "bourse", viewer: "me" }, NOW))[0]).toBe("pin")
  })

  it("filters 'pour-vous' on interests, featured items and own discussions", () => {
    const list = selectFeed(items, { tab: "pour-vous", viewer: "me", interests: ["cafe"] }, NOW)
    expect(ids(list)).toEqual(["mine"])
  })
})

describe("findSimilar", () => {
  const known = [
    { id: "1", title: "Ouvrir un PEA avec 5 000 € : par où commencer ?", repliesCount: 4, solved: true },
    { id: "2", title: "Assurance-vie après 70 ans", repliesCount: 3, solved: false },
    { id: "3", title: "Or physique : pièces ou lingots", repliesCount: 2, solved: false },
  ]

  it("returns nothing for stop words only", () => {
    expect(findSimilar(known, "comment faire pour")).toEqual([])
  })

  it("ranks by number of matching words and caps at three", () => {
    const result = findSimilar(known, "ouvrir PEA assurance-vie")
    expect(result.map((entry) => entry.id)).toEqual(["1", "2"])
  })
})
