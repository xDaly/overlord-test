import { describe, expect, it } from "vitest"

import { formatRelativeTime } from "./relative-time"

const NOW = new Date("2026-10-23T12:00:00Z")
const minutesAgo = (m: number) => new Date(NOW.getTime() - m * 60_000).toISOString()

describe("formatRelativeTime", () => {
  it("says 'à l'instant' under a minute", () => {
    expect(formatRelativeTime(minutesAgo(0.5), NOW)).toBe("à l'instant")
  })

  it("uses minutes under an hour", () => {
    expect(formatRelativeTime(minutesAgo(35), NOW)).toBe("il y a 35 min")
  })

  it("uses hours under a day", () => {
    expect(formatRelativeTime(minutesAgo(5 * 60), NOW)).toBe("il y a 5 h")
  })

  it("says 'hier' for one day", () => {
    expect(formatRelativeTime(minutesAgo(24 * 60), NOW)).toBe("hier")
  })

  it("uses days beyond that", () => {
    expect(formatRelativeTime(minutesAgo(9 * 24 * 60), NOW)).toBe("il y a 9 j")
  })
})
