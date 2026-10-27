import type { BadgeCode } from "./badges"
import { levelOf, type User } from "./user"

export type Effect =
  | { kind: "points"; points: number; reason: string; total: number }
  | { kind: "level"; name: string }
  | { kind: "badge"; code: BadgeCode }

export function awardPoints(user: User, points: number, reason: string): { user: User; effects: Effect[] } {
  const before = levelOf(user.points).index
  const next: User = { ...user, points: user.points + points, month: user.month + points }
  const effects: Effect[] = [{ kind: "points", points, reason, total: next.points }]
  const after = levelOf(next.points)
  if (after.index > before) effects.push({ kind: "level", name: after.name })
  return { user: next, effects }
}

export function grantBadge(user: User, code: BadgeCode): { user: User; effects: Effect[] } {
  if (user.badges.includes(code)) return { user, effects: [] }
  return { user: { ...user, badges: [...user.badges, code] }, effects: [{ kind: "badge", code }] }
}

const normalize = (text: string) => text.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase()

const MAX_MENTIONS = 6

export function mentionCandidates(
  users: User[],
  options: { query: string; me?: string; participants: string[] }
): User[] {
  const near = new Set(options.participants)
  const needle = normalize(options.query)
  return users
    .filter(
      (user) =>
        user.role !== "moderator" &&
        user.username !== options.me &&
        (!needle || normalize(user.username).includes(needle) || normalize(user.name).includes(needle))
    )
    .map((user) => {
      const prefix = needle && !normalize(user.name).startsWith(needle) && !normalize(user.username).startsWith(needle)
      const rank = (near.has(user.username) ? 0 : user.role === "redaction" ? 2 : 4) + (prefix ? 1 : 0)
      return { user, rank }
    })
    .sort((a, b) => a.rank - b.rank || b.user.points - a.user.points)
    .slice(0, MAX_MENTIONS)
    .map(({ user }) => user)
}

const MENTION = /@([A-Za-z0-9_-]+(?:\.[A-Za-z0-9_-]+)*)/g

export function extractMentions(text: string, knownUsernames: Iterable<string>, author?: string): string[] {
  const known = new Set(knownUsernames)
  return [...new Set([...text.matchAll(MENTION)].map((match) => match[1]))].filter(
    (username) => known.has(username) && username !== author
  )
}
