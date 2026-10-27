import { describe, expect, it } from "vitest"

import { slugify } from "./slug"

describe("slugify", () => {
  it("builds the same clean address as Strapi from a French title", () => {
    expect(slugify("Ouvrir un PEA avec 5 000 € : par où commencer ?")).toBe("ouvrir-un-pea-avec-5-000-par-ou-commencer")
    expect(slugify("  L'assurance-vie   et l'héritage !! ")).toBe("l-assurance-vie-et-l-heritage")
  })

  it("limits the length and falls back to a default", () => {
    expect(slugify("mot ".repeat(60)).length).toBeLessThanOrEqual(80)
    expect(slugify("???")).toBe("discussion")
  })
})
