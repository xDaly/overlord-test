import { levelOf, type User } from "@/modules/users/domain/user"

export const TRUSTED_DOMAINS = [
  "lerevenu.com",
  "gouv.fr",
  "service-public.fr",
  "amf-france.org",
  "banque-france.fr",
  "insee.fr",
  "info-retraite.fr",
  "ecb.europa.eu",
  "ccomptes.fr",
] as const

const LINK_PATTERN =
  /\b(?:https?:\/\/|www\.)[^\s<]+|\b[a-z0-9][a-z0-9-]*(?:\.[a-z0-9-]+)*\.(?:com|fr|net|org|eu|io|info|be|ch|co)\b(?:\/[^\s<]*)?/gi

const TRAILING_PUNCTUATION = /[.,;:!?)»]+$/

export const cleanLink = (raw: string) => raw.replace(TRAILING_PUNCTUATION, "")

export const hostOf = (raw: string) =>
  raw
    .replace(/^https?:\/\//i, "")
    .replace(/^www\./i, "")
    .split(/[/?#]/)[0]
    .toLowerCase()

export const isTrustedHost = (host: string) =>
  TRUSTED_DOMAINS.some((domain) => host === domain || host.endsWith(`.${domain}`))

export const canPostExternalLinks = (user: Pick<User, "role" | "points">) =>
  user.role === "redaction" || levelOf(user.points).index >= 3

export type LinkAnalysis = { status: "none" | "ok" | "warn" | "bad"; badHosts: string[] }

export function analyzeLinks(text: string, viewer: Pick<User, "role" | "points">): LinkAnalysis {
  const hosts = [...text.matchAll(LINK_PATTERN)].map((match) => hostOf(cleanLink(match[0])))
  if (!hosts.length) return { status: "none", badHosts: [] }
  const badHosts = [...new Set(hosts.filter((host) => !isTrustedHost(host)))]
  if (!badHosts.length) return { status: "ok", badHosts: [] }
  return { status: canPostExternalLinks(viewer) ? "warn" : "bad", badHosts }
}

export type TextPart =
  | { kind: "text"; value: string }
  | { kind: "link"; raw: string; host: string; trusted: boolean }

export function splitLinks(text: string): TextPart[] {
  const parts: TextPart[] = []
  const pushText = (value: string) => {
    if (!value) return
    const last = parts.at(-1)
    if (last?.kind === "text") last.value += value
    else parts.push({ kind: "text", value })
  }
  let cursor = 0
  for (const match of text.matchAll(LINK_PATTERN)) {
    const index = match.index ?? 0
    const link = cleanLink(match[0])
    pushText(text.slice(cursor, index))
    const host = hostOf(link)
    parts.push({ kind: "link", raw: link, host, trusted: isTrustedHost(host) })
    pushText(match[0].slice(link.length))
    cursor = index + match[0].length
  }
  pushText(text.slice(cursor))
  return parts
}
