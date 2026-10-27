import { describe, expect, it } from "vitest"

import { toUser } from "./strapi-member"

const now = new Date("2026-10-26T10:00:00Z")
const options = { publicUrl: "http://public.test", now }

describe("toUser", () => {
  it("reprend le profil et la gamification calculés par Strapi", () => {
    const user = toUser(
      {
        id: 1,
        username: "Vincent_ETF",
        displayName: "Vincent",
        communityRole: "member",
        avatarColor: "var(--av-1)",
        subscriber: true,
        points: 612,
        monthPoints: 148,
        monthKey: "2026-10",
        badges: ["bienvenue", "inconnu"],
        stats: { replies: 87 },
        avatar: { url: "/uploads/v.png" },
      },
      options
    )
    expect(user).toMatchObject({
      username: "Vincent_ETF",
      name: "Vincent",
      subscriber: true,
      points: 612,
      month: 148,
      badges: ["bienvenue"],
      stats: { topics: 0, replies: 87, likes: 0, solutions: 0, votes: 0 },
      photo: "http://public.test/uploads/v.png",
    })
  })

  it("ne compte pas pour le classement du mois les points d'un mois passé", () => {
    expect(toUser({ id: 1, username: "a", monthPoints: 40, monthKey: "2026-09" }, options).month).toBe(0)
  })

  it("complète un compte créé sans gamification", () => {
    expect(toUser({ id: 1, username: "nouveau" }, options)).toMatchObject({ name: "nouveau", role: "member", points: 0, badges: [] })
  })
})
