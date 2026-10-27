import { describe, expect, it } from "vitest"

import { parseLogin, parseRegistration } from "./credentials"

const fieldsOf = (action: () => unknown) => {
  try {
    action()
  } catch (error) {
    return (error as { code?: string; fields?: Record<string, string> }).fields
  }
  return undefined
}

describe("parseLogin", () => {
  it("trims the identifier and keeps the password as typed", () => {
    expect(parseLogin({ identifier: "  alex@exemple.fr ", password: " secret " })).toEqual({
      identifier: "alex@exemple.fr",
      password: " secret ",
    })
  })

  it("asks for both fields", () => {
    expect(fieldsOf(() => parseLogin({ identifier: " ", password: "" }))).toEqual({
      identifier: "identifier.required",
      password: "password.required",
    })
  })

  it("raises a validation error", () => {
    expect(() => parseLogin({})).toThrow(expect.objectContaining({ code: "validation" }))
  })
})

describe("parseRegistration", () => {
  const valid = { username: "Alex_75", email: " Alex@Exemple.FR ", password: "motdepasse1" }

  it("normalises the e-mail address", () => {
    expect(parseRegistration(valid)).toEqual({ username: "Alex_75", email: "alex@exemple.fr", password: "motdepasse1" })
  })

  it("accepts letters, digits and underscores from 3 to 24 characters", () => {
    expect(() => parseRegistration({ ...valid, username: "abc" })).not.toThrow()
    expect(() => parseRegistration({ ...valid, username: "a".repeat(24) })).not.toThrow()
  })

  it.each(["ab", "a".repeat(25), "avec espace", "accentué", "a-b-c", "@alex"])("refuses the username %j", (username) => {
    expect(fieldsOf(() => parseRegistration({ ...valid, username }))).toEqual({ username: "username.invalid" })
  })

  it.each(["", "alex", "alex@", "@exemple.fr", "alex@exemple"])("refuses the e-mail %j", (email) => {
    expect(fieldsOf(() => parseRegistration({ ...valid, email }))).toEqual({ email: "email.invalid" })
  })

  it("asks for at least 8 characters", () => {
    expect(fieldsOf(() => parseRegistration({ ...valid, password: "abc1" }))).toEqual({ password: "password.tooShort" })
  })

  it.each(["abcdefghij", "1234567890"])("asks for a letter and a digit: %j", (password) => {
    expect(fieldsOf(() => parseRegistration({ ...valid, password }))).toEqual({ password: "password.weak" })
  })

  it("reports every invalid field at once", () => {
    expect(fieldsOf(() => parseRegistration({ username: "a", email: "x", password: "y" }))).toEqual({
      username: "username.invalid",
      email: "email.invalid",
      password: "password.tooShort",
    })
  })
})
