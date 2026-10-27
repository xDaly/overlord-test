import type { StrapiClient } from "@/lib/strapi-client"
import type { Viewer } from "@/modules/discussions/infrastructure/strapi-discussion.repository"
import { BADGE_CODES, type BadgeCode } from "@/modules/users/domain/badges"
import type { NotificationRepository } from "../application/notification.repository"
import type { Notification, NotificationKind } from "../domain/notification"

export type StrapiNotificationEntry = {
  documentId: string
  kind: NotificationKind
  text: string
  read: boolean
  createdAt: string
  badge?: string | null
  actor?: { username: string } | null
  discussion?: { slug: string } | null
  blogPost?: { documentId: string } | null
}

const isNotFound = (error: unknown) => (error as { code?: string } | null)?.code === "not-found"

export function toNotification(entry: StrapiNotificationEntry): Notification {
  const notification: Notification = {
    id: entry.documentId,
    kind: entry.kind,
    text: entry.text,
    createdAt: entry.createdAt,
    read: entry.read,
  }
  if (entry.actor?.username) notification.actor = entry.actor.username
  if (entry.discussion?.slug) notification.discussionId = entry.discussion.slug
  if (entry.blogPost?.documentId) notification.blogId = entry.blogPost.documentId
  if (entry.badge && (BADGE_CODES as string[]).includes(entry.badge)) notification.badge = entry.badge as BadgeCode
  return notification
}

export class StrapiNotificationRepository implements NotificationRepository {
  constructor(private readonly deps: { client: StrapiClient; viewer: () => Promise<Viewer | null> }) {}

  async list(): Promise<Notification[]> {
    const viewer = await this.deps.viewer()
    if (!viewer) return []
    const result = await this.deps.client.get<{ data: StrapiNotificationEntry[] }>("/api/notifications", {}, { token: viewer.token })
    return result.data.map(toNotification)
  }

  async markRead(id: string): Promise<Notification | null> {
    const viewer = await this.deps.viewer()
    if (!viewer) return null
    try {
      const result = await this.deps.client.send<{ data: StrapiNotificationEntry }>("POST", `/api/notifications/${id}/read`, undefined, {
        token: viewer.token,
      })
      return toNotification(result.data)
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }

  async markAllRead(): Promise<void> {
    const viewer = await this.deps.viewer()
    if (viewer) await this.deps.client.send("POST", "/api/notifications/read-all", undefined, { token: viewer.token })
  }
}
