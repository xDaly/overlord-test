import { BADGE_CODES, type BadgeCode } from "../domain/badges"
import type { MemberStats, User, UserRole } from "../domain/user"

export type StrapiMember = {
  id: number
  username: string
  displayName?: string | null
  bio?: string | null
  interests?: string[] | null
  communityRole?: UserRole | null
  avatarColor?: string | null
  subscriber?: boolean | null
  expertTitle?: string | null
  points?: number | null
  monthPoints?: number | null
  monthKey?: string | null
  streak?: number | null
  badges?: string[] | null
  stats?: Partial<MemberStats> | null
  createdAt?: string
  avatar?: { url: string } | null
}

const ROLES: UserRole[] = ["member", "redaction", "moderator"]
const STAT_KEYS: (keyof MemberStats)[] = ["topics", "replies", "likes", "solutions", "votes"]

const absolute = (publicUrl: string, url: string) => (/^https?:\/\//.test(url) ? url : `${publicUrl}${url}`)

export const monthKeyOf = (date: Date) => date.toISOString().slice(0, 7)

export const unknownUser = (username: string): User => ({
  username,
  name: username,
  color: "var(--av-3)",
  role: "member",
  subscriber: false,
  points: 0,
  month: 0,
  bio: "",
  interests: [],
  badges: [],
  stats: { topics: 0, replies: 0, likes: 0, solutions: 0, votes: 0 },
})

export function toUser(member: StrapiMember, { publicUrl, now }: { publicUrl: string; now: Date }): User {
  const stats = Object.fromEntries(STAT_KEYS.map((key) => [key, member.stats?.[key] ?? 0])) as MemberStats
  const user: User = {
    username: member.username,
    name: member.displayName || member.username,
    color: member.avatarColor || "var(--av-3)",
    role: ROLES.includes(member.communityRole as UserRole) ? (member.communityRole as UserRole) : "member",
    subscriber: Boolean(member.subscriber),
    points: member.points ?? 0,
    month: member.monthKey === monthKeyOf(now) ? (member.monthPoints ?? 0) : 0,
    bio: member.bio ?? "",
    streak: member.streak ?? 0,
    interests: member.interests ?? [],
    badges: (member.badges ?? []).filter((code): code is BadgeCode => (BADGE_CODES as string[]).includes(code)),
    stats,
  }
  if (member.expertTitle) user.expertTitle = member.expertTitle
  if (member.avatar?.url) user.photo = absolute(publicUrl, member.avatar.url)
  if (member.createdAt) user.since = new Date(member.createdAt).toLocaleDateString("fr-FR", { month: "long", year: "numeric" })
  return user
}
