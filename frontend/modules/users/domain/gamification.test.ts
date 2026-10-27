import { describe, expect, it } from "vitest"

import { awardPoints, grantBadge, mentionCandidates } from "./gamification"
import { levelOf, type User } from "./user"

const user = (over: Partial<User> = {}): User => ({
  username: "Camille_B",
  name: "Camille",
  color: "var(--av-5)",
  role: "member",
  subscriber: true,
  points: 142,
  month: 64,
  bio: "",
  interests: [],
  badges: ["bienvenue"],
  stats: { topics: 1, replies: 9, likes: 23, solutions: 0, votes: 0 },
  ...over,
})

describe("levelOf", () => {
  it("starts as a newcomer", () => {
    expect(levelOf(0)).toMatchObject({ name: "Nouveau venu", next: 25, nextName: "Membre", progress: 0 })
  })

  it("computes progress toward the next level", () => {
    expect(levelOf(142)).toMatchObject({ name: "Contributeur", next: 300, progress: 21 })
  })

  it("caps the last level", () => {
    expect(levelOf(900)).toMatchObject({ name: "Pilier de la communauté", next: null, progress: 100 })
  })
})

describe("awardPoints", () => {
  it("adds points to the total and to the month", () => {
    const { user: next, effects } = awardPoints(user(), 3, "Merci pour votre réponse")
    expect(next.points).toBe(145)
    expect(next.month).toBe(67)
    expect(effects).toEqual([{ kind: "points", points: 3, reason: "Merci pour votre réponse", total: 145 }])
  })

  it("announces a level up", () => {
    const { effects } = awardPoints(user({ points: 98 }), 5, "Discussion publiée")
    expect(effects).toContainEqual({ kind: "level", name: "Contributeur" })
  })
})

describe("grantBadge", () => {
  it("grants a new badge once", () => {
    const first = grantBadge(user(), "citoyen")
    expect(first.user.badges).toContain("citoyen")
    expect(first.effects).toEqual([{ kind: "badge", code: "citoyen" }])
    expect(grantBadge(first.user, "citoyen").effects).toEqual([])
  })
})

describe("mentionCandidates", () => {
  const people: User[] = [
    user({ username: "LaRedaction", name: "La rédaction du Revenu", role: "redaction", points: 0 }),
    user({ username: "Moderation", name: "Équipe modération", role: "moderator", points: 0 }),
    user({ username: "Vincent_ETF", name: "Vincent", points: 612 }),
    user({ username: "Odile.Retraite", name: "Odile", points: 286 }),
    user({ username: "Camille_B", name: "Camille", points: 142 }),
  ]

  it("excludes moderators and the current user", () => {
    const names = mentionCandidates(people, { query: "", me: "Camille_B", participants: [] }).map((u) => u.username)
    expect(names).not.toContain("Moderation")
    expect(names).not.toContain("Camille_B")
  })

  it("puts participants of the page first, then the redaction", () => {
    const names = mentionCandidates(people, { query: "", me: "Camille_B", participants: ["Odile.Retraite"] }).map((u) => u.username)
    expect(names).toEqual(["Odile.Retraite", "LaRedaction", "Vincent_ETF"])
  })

  it("filters accent-insensitively on name and username", () => {
    const names = mentionCandidates(people, { query: "redac", me: "Camille_B", participants: [] }).map((u) => u.username)
    expect(names).toEqual(["LaRedaction"])
  })
})
