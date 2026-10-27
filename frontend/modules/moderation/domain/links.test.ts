import { describe, expect, it } from "vitest"

import { analyzeLinks, canPostExternalLinks, hostOf, isTrustedHost, splitLinks } from "./links"

describe("hostOf", () => {
  it("strips protocol, www and path", () => {
    expect(hostOf("https://www.Service-Public.fr/particuliers/vosdroits")).toBe("service-public.fr")
  })
})

describe("isTrustedHost", () => {
  it("accepts official domains and their subdomains", () => {
    expect(isTrustedHost("lerevenu.com")).toBe(true)
    expect(isTrustedHost("impots.gouv.fr")).toBe(true)
  })

  it("refuses other domains, including look-alikes", () => {
    expect(isTrustedHost("mon-courtier.com")).toBe(false)
    expect(isTrustedHost("fakelerevenu.com")).toBe(false)
  })
})

describe("canPostExternalLinks", () => {
  it("is reserved to the redaction and confirmed members", () => {
    expect(canPostExternalLinks({ role: "redaction", points: 0 })).toBe(true)
    expect(canPostExternalLinks({ role: "member", points: 300 })).toBe(true)
    expect(canPostExternalLinks({ role: "member", points: 142 })).toBe(false)
  })
})

describe("analyzeLinks", () => {
  const newcomer = { role: "member" as const, points: 10 }

  it("reports no link", () => {
    expect(analyzeLinks("Aucun lien ici", newcomer).status).toBe("none")
  })

  it("accepts trusted links", () => {
    expect(analyzeLinks("Voir www.amf-france.org/fr", newcomer).status).toBe("ok")
  })

  it("refuses untrusted links for a newcomer", () => {
    const result = analyzeLinks("Essayez https://super-courtier.com/offre", newcomer)
    expect(result).toEqual({ status: "bad", badHosts: ["super-courtier.com"] })
  })

  it("sends untrusted links of confirmed members to moderation", () => {
    const result = analyzeLinks("Essayez https://super-courtier.com", { role: "member", points: 400 })
    expect(result.status).toBe("warn")
  })
})

describe("splitLinks", () => {
  it("keeps the trailing punctuation outside the link", () => {
    const parts = splitLinks("Lisez lerevenu.com/bourse, puis revenez.")
    expect(parts).toEqual([
      { kind: "text", value: "Lisez " },
      { kind: "link", raw: "lerevenu.com/bourse", host: "lerevenu.com", trusted: true },
      { kind: "text", value: ", puis revenez." },
    ])
  })
})
