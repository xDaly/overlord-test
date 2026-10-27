import { describe, expect, it, vi } from "vitest"

import type { StrapiClient } from "@/lib/strapi-client"
import { StrapiNotificationRepository, toNotification } from "./strapi-notification.repository"

const viewer = { id: 7, username: "Camille_B", token: "member-token" }

describe("toNotification", () => {
  it("mène à la discussion (par son adresse) ou au billet concerné", () => {
    expect(
      toNotification({
        documentId: "n1",
        kind: "reply",
        text: "a répondu",
        read: false,
        createdAt: "2026-10-26T10:00:00Z",
        actor: { username: "Vincent_ETF" },
        discussion: { slug: "ma-discussion" },
      })
    ).toEqual({ id: "n1", kind: "reply", text: "a répondu", read: false, createdAt: "2026-10-26T10:00:00Z", actor: "Vincent_ETF", discussionId: "ma-discussion" })
    expect(toNotification({ documentId: "n2", kind: "like", text: "x", read: true, createdAt: "", blogPost: { documentId: "b1" } }).blogId).toBe("b1")
  })
})

describe("StrapiNotificationRepository", () => {
  it("lit les notifications avec le jeton du membre, jamais celui du serveur", async () => {
    const get = vi.fn(async () => ({ data: [] }))
    const repository = new StrapiNotificationRepository({ client: { get, send: vi.fn() } as unknown as StrapiClient, viewer: async () => viewer })
    await repository.list()
    expect(get).toHaveBeenCalledWith("/api/notifications", {}, { token: "member-token" })
  })

  it("ne renvoie rien à un visiteur", async () => {
    const get = vi.fn()
    const repository = new StrapiNotificationRepository({ client: { get, send: vi.fn() } as unknown as StrapiClient, viewer: async () => null })
    expect(await repository.list()).toEqual([])
    expect(get).not.toHaveBeenCalled()
  })
})
