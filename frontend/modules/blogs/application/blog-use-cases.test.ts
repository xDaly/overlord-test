import { beforeEach, describe, expect, it } from "vitest"

import { asDeps, member, stubDeps } from "@/modules/community/testing/stub-deps"
import { commentBlog } from "./comment-blog.use-case"
import { publishBlog } from "./publish-blog.use-case"
import { toggleBlogUseful } from "./toggle-blog-useful.use-case"

const camille = member("Camille_B", { points: 142 })

const post = {
  title: "Mon bilan après cinq ans de versements",
  content: "Je verse chaque mois la même somme sur un ETF monde. Voici ce que j'en retiens après cinq ans de pratique régulière.",
  categorySlug: "bourse",
}

describe("blog use cases", () => {
  let stubs: ReturnType<typeof stubDeps>

  beforeEach(() => {
    stubs = stubDeps()
  })

  describe("publishBlog", () => {
    it("refuses an anonymous visitor", async () => {
      await expect(publishBlog(asDeps(stubs), null, post)).rejects.toMatchObject({ code: "unauthenticated" })
    })

    it("requires a 10-character title and a 60-character body", async () => {
      await expect(publishBlog(asDeps(stubs), camille, { ...post, title: "Court", content: "Trop bref." })).rejects.toMatchObject({
        code: "validation",
        fields: { title: "title.tooShort", content: "content.tooShort" },
      })
      expect(stubs.blogs.create).not.toHaveBeenCalled()
    })

    it("publishes through Strapi and returns its effects and mentions", async () => {
      const effect = { kind: "points", points: 5, reason: "Billet publié", total: 147 }
      stubs.blogs.create.mockResolvedValue({ item: { id: "b1" }, effects: [effect], mentioned: ["Vincent"] })
      const result = await publishBlog(asDeps(stubs), camille, { ...post, categorySlug: null })
      expect(stubs.blogs.create).toHaveBeenCalledWith({ title: post.title, content: post.content, categorySlug: null })
      expect(result).toEqual({ post: { id: "b1" }, effects: [effect], mentioned: ["Vincent"] })
    })
  })

  describe("commentBlog", () => {
    it("rejects an empty comment", async () => {
      await expect(commentBlog(asDeps(stubs), camille, "b1", " ")).rejects.toMatchObject({ code: "validation" })
    })

    it("reports a missing post", async () => {
      stubs.blogs.addComment.mockResolvedValue(null)
      await expect(commentBlog(asDeps(stubs), camille, "inconnu", "Merci !")).rejects.toMatchObject({ code: "not-found" })
    })
  })

  describe("toggleBlogUseful", () => {
    it("passes Strapi's answer through", async () => {
      stubs.blogs.toggleLike.mockResolvedValue({ liked: true, likes: 59, rewardedAuthor: "Vincent" })
      await expect(toggleBlogUseful(asDeps(stubs), camille, "b1", null)).resolves.toMatchObject({ liked: true, likes: 59 })
    })

    it("refuses an anonymous visitor", async () => {
      await expect(toggleBlogUseful(asDeps(stubs), null, "b1", null)).rejects.toMatchObject({ code: "unauthenticated" })
    })
  })
})
