import { describe, expect, it, vi } from "vitest"

import type { StrapiClient } from "@/lib/strapi-client"
import { fetchCategories, toCategory, type StrapiCategoryEntry } from "./strapi-category.catalog"

const entry = (patch: Partial<StrapiCategoryEntry> = {}): StrapiCategoryEntry => ({
  slug: "bourse",
  name: "Bourse & actions",
  description: "Actions, ETF, PEA.",
  icon: "candles",
  color: "#007aff",
  siteSection: "Réussir en Bourse",
  discussionsCount: 12,
  repliesCount: 40,
  ...patch,
})

describe("toCategory", () => {
  it("reprend la présentation et les compteurs calculés par Strapi", () => {
    expect(toCategory(entry())).toEqual({
      slug: "bourse",
      name: "Bourse & actions",
      description: "Actions, ETF, PEA.",
      icon: "candles",
      color: "#007aff",
      topicsCount: 12,
      repliesCount: 40,
      siteSection: "Réussir en Bourse",
    })
  })

  it("complète un espace saisi sans icône, couleur, description ni compteurs", () => {
    const category = toCategory(
      entry({ description: null, icon: null, color: "", siteSection: "", discussionsCount: undefined, repliesCount: undefined })
    )
    expect(category).toMatchObject({ description: "", icon: "coffee", color: "#8e8e93", siteSection: null, topicsCount: 0, repliesCount: 0 })
  })
})

describe("fetchCategories", () => {
  it("lit les espaces dans Strapi, dans l'ordre de création", async () => {
    const get = vi.fn(async () => ({ data: [entry(), entry({ slug: "cafe", name: "Le Café du Revenu" })] }))
    const categories = await fetchCategories({ get, send: vi.fn() } as unknown as StrapiClient)

    expect(get).toHaveBeenCalledWith("/api/categories", expect.objectContaining({ sort: ["id:asc"] }))
    expect(categories.map((category) => category.slug)).toEqual(["bourse", "cafe"])
  })
})
