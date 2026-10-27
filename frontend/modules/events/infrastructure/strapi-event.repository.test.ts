import { describe, expect, it, vi } from "vitest"

import type { StrapiClient } from "@/lib/strapi-client"
import { StrapiEventRepository, toEvent } from "./strapi-event.repository"

const entry = {
  documentId: "e1",
  title: "Le Revenu répond",
  host: "La rédaction",
  startsAt: "2026-10-29T17:30:00.000Z",
  goingBase: 142,
  category: { slug: "assurance-vie" },
  attendees: [{ id: 7 }],
}

describe("toEvent", () => {
  it("compte les inscrits et sait si le membre connecté en fait partie", () => {
    expect(toEvent(entry, 7)).toMatchObject({ id: "e1", going: 143, joined: true, categorySlug: "assurance-vie" })
    expect(toEvent(entry, null).joined).toBe(false)
  })
})

describe("StrapiEventRepository", () => {
  it("ne demande que les rendez-vous à venir, triés par date", async () => {
    const get = vi.fn(async () => ({ data: [entry] }))
    const repository = new StrapiEventRepository({
      client: { get, send: vi.fn() } as unknown as StrapiClient,
      viewer: async () => null,
      now: () => new Date("2026-10-26T10:00:00Z"),
    })
    await repository.list({ categorySlug: "assurance-vie" })
    expect(get).toHaveBeenCalledWith(
      "/api/events",
      expect.objectContaining({
        filters: { startsAt: { $gte: "2026-10-26T10:00:00.000Z" }, category: { slug: { $eq: "assurance-vie" } } },
        sort: ["startsAt:asc"],
      })
    )
  })

  it("refuse l'inscription d'un visiteur", async () => {
    const repository = new StrapiEventRepository({ client: { get: vi.fn(), send: vi.fn() } as unknown as StrapiClient, viewer: async () => null })
    await expect(repository.toggleRsvp("e1")).rejects.toMatchObject({ code: "unauthenticated" })
  })
})
