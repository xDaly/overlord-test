import { describe, expect, it } from "vitest"

import { accessMaxAge, jwtExpiry, needsRefresh } from "./session"

const NOW = Date.UTC(2026, 9, 23, 12, 0, 0)
const jwt = (exp?: number) => {
  const encode = (value: object) => Buffer.from(JSON.stringify(value)).toString("base64url")
  return `${encode({ alg: "HS256" })}.${encode(exp === undefined ? {} : { exp })}.signature`
}
const inSeconds = (seconds: number) => Math.floor(NOW / 1000) + seconds

describe("jwtExpiry", () => {
  it("reads the exp claim", () => {
    expect(jwtExpiry(jwt(1_800_000_000))).toBe(1_800_000_000)
  })

  it.each(["", "abc", "a.b.c", "a.%%%.c"])("returns null for the malformed token %j", (token) => {
    expect(jwtExpiry(token)).toBeNull()
  })

  it("returns null when the token has no exp", () => {
    expect(jwtExpiry(jwt())).toBeNull()
  })
})

describe("needsRefresh", () => {
  it("refreshes when there is no access token", () => {
    expect(needsRefresh(undefined, NOW)).toBe(true)
    expect(needsRefresh("", NOW)).toBe(true)
  })

  it("refreshes an unreadable token", () => {
    expect(needsRefresh("garbage", NOW)).toBe(true)
  })

  it("refreshes an expired token", () => {
    expect(needsRefresh(jwt(inSeconds(-1)), NOW)).toBe(true)
  })

  it("refreshes a token that expires within the safety margin", () => {
    expect(needsRefresh(jwt(inSeconds(20)), NOW, 30_000)).toBe(true)
  })

  it("keeps a token that is still valid beyond the margin", () => {
    expect(needsRefresh(jwt(inSeconds(300)), NOW, 30_000)).toBe(false)
  })
})

describe("accessMaxAge", () => {
  it("lasts until the token expires", () => {
    expect(accessMaxAge(jwt(inSeconds(600)), NOW)).toBe(600)
  })

  it("never goes below one second", () => {
    expect(accessMaxAge(jwt(inSeconds(-50)), NOW)).toBe(1)
  })

  it("falls back to a default for an unreadable token", () => {
    expect(accessMaxAge("garbage", NOW, 123)).toBe(123)
  })
})
