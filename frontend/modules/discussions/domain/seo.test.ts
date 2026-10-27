import { describe, expect, it } from "vitest"

import { blogSeo, seoStatus, type SeoInput } from "./seo"

const base = (over: Partial<SeoInput> = {}): SeoInput => ({
  categorySlug: "bourse",
  usefulCount: 0,
  repliesCount: 0,
  solutionVerified: null,
  hasExpertParticipant: false,
  expertIsRedaction: false,
  ...over,
})

describe("seoStatus", () => {
  it("never indexes the free discussion space", () => {
    const status = seoStatus(base({ categorySlug: "cafe", solutionVerified: true }))
    expect(status.on).toBe(false)
    expect(status.reason).toBe("Espace de discussion libre : jamais indexé")
  })

  it("indexes a discussion with a chosen best answer", () => {
    expect(seoStatus(base({ solutionVerified: false }))).toMatchObject({ on: true, reason: "Meilleure réponse choisie" })
  })

  it("mentions the verification of the best answer", () => {
    expect(seoStatus(base({ solutionVerified: true })).reason).toBe("Meilleure réponse vérifiée par la rédaction")
  })

  it("indexes when the redaction answered", () => {
    expect(seoStatus(base({ hasExpertParticipant: true, expertIsRedaction: true }))).toMatchObject({
      on: true,
      reason: "Contribution de la rédaction",
    })
  })

  it("indexes when a verified expert answered", () => {
    expect(seoStatus(base({ hasExpertParticipant: true })).reason).toBe("Réponse d'un expert vérifié")
  })

  it("indexes a discussion judged useful by enough readers", () => {
    expect(seoStatus(base({ usefulCount: 30, repliesCount: 2 }))).toMatchObject({
      on: true,
      reason: "Discussion jugée utile (30 « Utile »)",
    })
  })

  it("explains why a discussion is not indexed yet", () => {
    expect(seoStatus(base()).reason).toBe("Pas encore de réponse")
    expect(seoStatus(base({ repliesCount: 1 })).reason).toBe("Pas encore assez de signaux de qualité")
  })

  it("lists the four checks", () => {
    expect(seoStatus(base()).checks).toHaveLength(4)
  })
})

describe("blogSeo", () => {
  it("indexes liked posts only", () => {
    expect(blogSeo(20).on).toBe(true)
    expect(blogSeo(19)).toMatchObject({ on: false, reason: "En attente de relecture par la rédaction" })
  })
})
