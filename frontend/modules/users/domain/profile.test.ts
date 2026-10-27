import { describe, expect, it } from "vitest"

import { AVATAR_MAX_BYTES, BIO_MAX, assertAvatar, parseProfile } from "./profile"

const fieldsOf = (action: () => unknown) => {
  try {
    action()
  } catch (error) {
    return (error as { fields?: Record<string, string> }).fields
  }
  return undefined
}

describe("parseProfile", () => {
  it("cleans the pseudo and the bio", () => {
    expect(parseProfile({ pseudo: "  Épargnant   du Nord ", bio: "  Bonjour  ", interests: ["bourse"] })).toEqual({
      pseudo: "Épargnant du Nord",
      bio: "Bonjour",
      interests: ["bourse"],
    })
  })

  it("accepts an empty bio and no interests", () => {
    expect(parseProfile({ pseudo: "Alex", bio: "", interests: [] })).toEqual({ pseudo: "Alex", bio: "", interests: [] })
  })

  it("refuses a pseudo under 3 characters", () => {
    expect(fieldsOf(() => parseProfile({ pseudo: " Al ", bio: "", interests: [] }))).toEqual({ pseudo: "pseudo.tooShort" })
  })

  it("cuts a pseudo longer than 24 characters", () => {
    expect(parseProfile({ pseudo: "a".repeat(40), bio: "", interests: [] }).pseudo).toHaveLength(24)
  })

  it("refuses a bio over the limit", () => {
    expect(fieldsOf(() => parseProfile({ pseudo: "Alex", bio: "a".repeat(BIO_MAX + 1), interests: [] }))).toEqual({
      bio: "bio.tooLong",
    })
  })

  it("removes duplicate interests", () => {
    expect(parseProfile({ pseudo: "Alex", bio: "", interests: ["bourse", "bourse", "retraite"] }).interests).toEqual([
      "bourse",
      "retraite",
    ])
  })
})

describe("assertAvatar", () => {
  const png = { type: "image/png", size: 10_000 }

  it("accepts the supported image types within the size limit", () => {
    for (const type of ["image/jpeg", "image/png", "image/webp", "image/gif"]) {
      expect(() => assertAvatar({ ...png, type })).not.toThrow()
    }
    expect(() => assertAvatar({ ...png, size: AVATAR_MAX_BYTES })).not.toThrow()
  })

  it("refuses another file type", () => {
    expect(fieldsOf(() => assertAvatar({ type: "image/svg+xml", size: 100 }))).toEqual({ photo: "photo.invalidType" })
    expect(fieldsOf(() => assertAvatar({ type: "text/html", size: 100 }))).toEqual({ photo: "photo.invalidType" })
  })

  it("refuses an oversized file", () => {
    expect(fieldsOf(() => assertAvatar({ ...png, size: AVATAR_MAX_BYTES + 1 }))).toEqual({ photo: "photo.tooLarge" })
  })

  it("refuses a missing file", () => {
    expect(fieldsOf(() => assertAvatar(undefined))).toEqual({ photo: "photo.required" })
  })
})
