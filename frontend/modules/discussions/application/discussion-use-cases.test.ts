import { beforeEach, describe, expect, it } from "vitest"

import { asDeps, member, stubDeps } from "@/modules/community/testing/stub-deps"
import { chooseSolution } from "./choose-solution.use-case"
import { createDiscussion } from "./create-discussion.use-case"
import { publishReply } from "./publish-reply.use-case"
import { toggleUseful } from "./toggle-useful.use-case"
import { verifyReply } from "./verify-reply.use-case"
import { votePoll } from "./vote-poll.use-case"

const camille = member("Camille_B", { points: 142 })
const thomas = member("Thomas_PEA", { points: 58 })
const newcomer = member("Alex", { points: 0 })
const points = { kind: "points", points: 5, reason: "Discussion publiée", total: 147 } as const

describe("discussion use cases", () => {
  let stubs: ReturnType<typeof stubDeps>

  beforeEach(() => {
    stubs = stubDeps()
  })

  describe("createDiscussion", () => {
    const input = {
      title: "Comment choisir une assurance-vie ?",
      content: "Je compare plusieurs contrats.",
      type: "question" as const,
      categorySlug: "assurance-vie",
    }

    it("refuses an anonymous visitor without calling Strapi", async () => {
      await expect(createDiscussion(asDeps(stubs), null, input)).rejects.toMatchObject({ code: "unauthenticated" })
      expect(stubs.discussions.create).not.toHaveBeenCalled()
    })

    it("returns field errors for an invalid title", async () => {
      await expect(createDiscussion(asDeps(stubs), camille, { ...input, title: "court" })).rejects.toMatchObject({
        code: "validation",
        fields: { title: "title.tooShort" },
      })
    })

    it("requires two options for a poll", async () => {
      await expect(
        createDiscussion(asDeps(stubs), camille, { ...input, type: "poll", options: ["Une seule", " "] })
      ).rejects.toMatchObject({ fields: { options: "options.tooFew" } })
    })

    it("refuses links that a newcomer may not post", async () => {
      await expect(
        createDiscussion(asDeps(stubs), newcomer, { ...input, content: "Voyez https://super-courtier.com/offre" })
      ).rejects.toMatchObject({ fields: { content: "content.links" } })
    })

    it("sends the cleaned discussion to Strapi and returns the points it granted", async () => {
      stubs.discussions.create.mockResolvedValue({ item: { id: "ma-discussion" }, effects: [points], mentioned: [] })
      const result = await createDiscussion(asDeps(stubs), camille, { ...input, title: "  Comment   choisir une assurance-vie ? " })
      expect(stubs.discussions.create).toHaveBeenCalledWith(camille, expect.objectContaining({ title: "Comment choisir une assurance-vie ?" }))
      expect(result).toEqual({ discussion: { id: "ma-discussion" }, effects: [points] })
    })
  })

  describe("publishReply", () => {
    it("refuses an anonymous visitor", async () => {
      await expect(publishReply(asDeps(stubs), null, "4", "Merci")).rejects.toMatchObject({ code: "unauthenticated" })
    })

    it("rejects an empty reply without calling Strapi", async () => {
      await expect(publishReply(asDeps(stubs), camille, "4", "  ")).rejects.toMatchObject({ code: "validation" })
      expect(stubs.discussions.addReply).not.toHaveBeenCalled()
    })

    it("returns the reply, the points and the members Strapi notified", async () => {
      stubs.discussions.addReply.mockResolvedValue({ item: { id: "r1" }, effects: [points], mentioned: ["Vincent"] })
      const result = await publishReply(asDeps(stubs), camille, "4", " Merci @Vincent_ETF ")
      expect(stubs.discussions.addReply).toHaveBeenCalledWith("4", "Merci @Vincent_ETF")
      expect(result).toEqual({ reply: { id: "r1" }, effects: [points], mentioned: ["Vincent"] })
    })

    it("fails on an unknown discussion", async () => {
      stubs.discussions.addReply.mockResolvedValue(null)
      await expect(publishReply(asDeps(stubs), camille, "999", "Bonjour")).rejects.toMatchObject({ code: "not-found" })
    })
  })

  describe("toggleUseful", () => {
    it("refuses an anonymous visitor", async () => {
      await expect(toggleUseful(asDeps(stubs), null, "4", null)).rejects.toMatchObject({ code: "unauthenticated" })
    })

    it("passes Strapi's answer through, including who was rewarded", async () => {
      stubs.discussions.toggleLike.mockResolvedValue({ liked: true, likes: 20, rewardedAuthor: "Thomas" })
      await expect(toggleUseful(asDeps(stubs), camille, "4", "r2")).resolves.toEqual({ liked: true, likes: 20, rewardedAuthor: "Thomas" })
      expect(stubs.discussions.toggleLike).toHaveBeenCalledWith("4", "r2")
    })

    it("reports a missing message", async () => {
      stubs.discussions.toggleLike.mockResolvedValue(null)
      await expect(toggleUseful(asDeps(stubs), camille, "4", null)).rejects.toMatchObject({ code: "not-found" })
    })
  })

  describe("votePoll", () => {
    it("returns the effects of a first vote", async () => {
      stubs.discussions.vote.mockResolvedValue({ first: true, effects: [points] })
      await expect(votePoll(asDeps(stubs), camille, "3", 1)).resolves.toEqual({ effects: [points] })
    })

    it("refuses an anonymous visitor", async () => {
      await expect(votePoll(asDeps(stubs), null, "3", 0)).rejects.toMatchObject({ code: "unauthenticated" })
    })
  })

  describe("chooseSolution", () => {
    const question = { type: "question", author: thomas }

    it("lets the author of a question choose, and thanks them with the answerer's reward", async () => {
      stubs.discussions.findById.mockResolvedValue(question)
      stubs.discussions.toggleSolution.mockResolvedValue({ solutionId: "r1", answerer: "Papy Boursier", points: 20 })
      const { solutionId, effects } = await chooseSolution(asDeps(stubs), thomas, "4", "r1")
      expect(solutionId).toBe("r1")
      expect(effects).toEqual([
        {
          kind: "message",
          icon: "check",
          title: "Meilleure réponse choisie",
          text: "Papy Boursier reçoit +20 points. Merci d'avoir clôturé votre question !",
        },
      ])
    })

    it("forbids other members", async () => {
      stubs.discussions.findById.mockResolvedValue(question)
      await expect(chooseSolution(asDeps(stubs), camille, "4", "r1")).rejects.toMatchObject({ code: "forbidden" })
      expect(stubs.discussions.toggleSolution).not.toHaveBeenCalled()
    })

    it("only applies to questions", async () => {
      stubs.discussions.findById.mockResolvedValue({ ...question, type: "discussion" })
      await expect(chooseSolution(asDeps(stubs), thomas, "7", "r1")).rejects.toMatchObject({ code: "forbidden" })
    })
  })

  describe("verifyReply", () => {
    it("refuses an anonymous visitor", async () => {
      await expect(verifyReply(asDeps(stubs), null, "4", "r1")).rejects.toMatchObject({ code: "unauthenticated" })
    })
  })
})
