import { BADGE_CODES, type BadgeCode } from "./badges"

export type UserRole = "member" | "redaction" | "moderator"

export type MemberStats = {
  topics: number
  replies: number
  likes: number
  solutions: number
  votes: number
}

export type User = {
  username: string
  name: string
  color: string
  role: UserRole
  subscriber: boolean
  points: number
  month: number
  bio: string
  expertTitle?: string
  streak?: number
  interests: string[]
  badges: BadgeCode[]
  stats: MemberStats
  photo?: string
  since?: string
}

export const LEVELS: ReadonlyArray<readonly [min: number, name: string]> = [
  [0, "Nouveau venu"],
  [25, "Membre"],
  [100, "Contributeur"],
  [300, "Contributeur averti"],
  [750, "Pilier de la communauté"],
]

export type Level = {
  index: number
  name: string
  min: number
  next: number | null
  nextName: string | null
  progress: number
}

export function levelOf(points: number): Level {
  let index = 0
  LEVELS.forEach(([min], i) => {
    if (points >= min) index = i
  })
  const next = LEVELS[index + 1]
  const [min, name] = LEVELS[index]
  return {
    index,
    name,
    min,
    next: next ? next[0] : null,
    nextName: next ? next[1] : null,
    progress: next ? Math.round(((points - min) * 100) / (next[0] - min)) : 100,
  }
}

export const levelName = (points: number) => levelOf(points).name

export const isExpert = (user: User) => user.role === "redaction" || Boolean(user.expertTitle)

export function initialsOf(user: Pick<User, "name" | "role">): string {
  if (user.role === "redaction") return "R"
  return user.name
    .split(/\s+/)
    .map((word) => word[0])
    .slice(0, 2)
    .join("")
    .toUpperCase()
}

const MONTHS = [
  "janvier", "février", "mars", "avril", "mai", "juin",
  "juillet", "août", "septembre", "octobre", "novembre", "décembre",
]

export function memberSince(user: Pick<User, "username" | "since">): string {
  if (user.since) return user.since
  const hash = [...user.username].reduce((sum, char) => sum + char.charCodeAt(0), 0)
  return `${MONTHS[hash % 12]} ${2019 + (hash % 7)}`
}

export function defaultStats(points: number, topics: number): MemberStats {
  return {
    topics,
    replies: Math.round(points / 7),
    likes: Math.round(points / 4),
    solutions: Math.round(points / 120),
    votes: 0,
  }
}

export function defaultBadges(points: number): BadgeCode[] {
  return BADGE_CODES.slice(0, Math.min(9, Math.round(points / 80) + 2))
}
