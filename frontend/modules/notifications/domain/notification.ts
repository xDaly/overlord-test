import type { BadgeCode } from "@/modules/users/domain/badges"

export type NotificationKind = "reply" | "like" | "mention" | "badge" | "solution" | "level" | "event"

export type Notification = {
  id: string
  kind: NotificationKind
  actor?: string
  discussionId?: string
  blogId?: string
  badge?: BadgeCode
  text: string
  createdAt: string
  read: boolean
}
