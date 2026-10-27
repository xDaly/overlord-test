import type { BlogRepository } from "@/modules/blogs/application/blog.repository"
import type { DiscussionRepository } from "@/modules/discussions/application/discussion.repository"
import type { EventRepository } from "@/modules/events/application/event.repository"
import type { NotificationRepository } from "@/modules/notifications/application/notification.repository"
import type { UserRepository } from "@/modules/users/application/user.repository"
import type { Effect } from "@/modules/users/domain/gamification"

export type CommunityDeps = {
  discussions: DiscussionRepository
  blogs: BlogRepository
  events: EventRepository
  users: UserRepository
  notifications: NotificationRepository
}

export type Published<T> = { item: T; effects: Effect[]; mentioned: string[] }

export type UsefulResult = { liked: boolean; likes: number; rewardedAuthor: string | null }

export type MessageEffect = {
  kind: "message"
  icon: "thumb" | "bell" | "check" | "verified" | "calendar" | "link" | "shield" | "camera" | "at" | "eye" | "user" | "globe"
  title?: string
  text: string
  delayMs?: number
}
