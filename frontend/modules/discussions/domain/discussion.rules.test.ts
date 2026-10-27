import { describe, expect, it } from "vitest"

import {
  MIN_TITLE_LENGTH,
  normalizeTitle,
  validateNewDiscussion,
} from "./discussion.rules"

describe("normalizeTitle", () => {
  it("trims and collapses inner whitespace", () => {
    expect(normalizeTitle("  Ouvrir   un PEA  ")).toBe("Ouvrir un PEA")
  })
})

describe("validateNewDiscussion", () => {
  const valid = {
    title: "Ouvrir un PEA avec 5 000 € ?",
    content: "Par où commencer ?",
    type: "question" as const,
    categorySlug: "bourse",
  }

  it("accepts a complete discussion", () => {
    expect(validateNewDiscussion(valid)).toEqual({})
  })

  it("rejects a title shorter than the minimum", () => {
    const title = "Trop bref"
    expect(title.length).toBe(MIN_TITLE_LENGTH - 1)
    expect(validateNewDiscussion({ ...valid, title }).title).toBe("title.tooShort")
  })

  it("accepts a title of exactly the minimum length", () => {
    const title = "Dix signes"
    expect(title.length).toBe(MIN_TITLE_LENGTH)
    expect(validateNewDiscussion({ ...valid, title }).title).toBeUndefined()
  })

  it("counts the normalized title, not the raw one", () => {
    const errors = validateNewDiscussion({ ...valid, title: "   abc      def   " })
    expect(errors.title).toBe("title.tooShort")
  })

  it("rejects an empty content", () => {
    expect(validateNewDiscussion({ ...valid, content: "   " }).content).toBe(
      "content.required"
    )
  })

  it("rejects a missing category", () => {
    expect(validateNewDiscussion({ ...valid, categorySlug: "" }).category).toBe(
      "category.required"
    )
  })

  it("rejects an unknown type", () => {
    const errors = validateNewDiscussion({
      ...valid,
      type: "autre" as unknown as "question",
    })
    expect(errors.type).toBe("type.invalid")
  })
})
