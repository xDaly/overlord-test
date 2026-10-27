import { describe, expect, it } from "vitest"

import { unknownCategory } from "@/modules/categories/domain/category"
import { asDeps, member, stubDeps } from "@/modules/community/testing/stub-deps"
import { getCommunityStats } from "./community-stats"

const categories = [
  { ...unknownCategory("bourse"), topicsCount: 3, repliesCount: 6 },
  { ...unknownCategory("retraite"), topicsCount: 2, repliesCount: 4 },
]

describe("getCommunityStats", () => {
  it("compte les membres, les discussions et les réponses réels, sans les comptes de service", async () => {
    const stubs = stubDeps()
    stubs.users.list.mockResolvedValue([member("a"), member("b"), member("LaRedaction", { role: "redaction" }), member("Moderation", { role: "moderator" })])
    stubs.discussions.questionStats.mockResolvedValue({ total: 4, solved: 3 })
    expect(await getCommunityStats(asDeps(stubs), categories)).toEqual({ members: 2, discussions: 5, replies: 10, resolvedPercent: 75 })
  })

  it("n'invente pas de pourcentage quand il n'y a aucune question", async () => {
    const stubs = stubDeps()
    stubs.users.list.mockResolvedValue([])
    stubs.discussions.questionStats.mockResolvedValue({ total: 0, solved: 0 })
    expect((await getCommunityStats(asDeps(stubs), [])).resolvedPercent).toBeNull()
  })
})
