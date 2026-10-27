import type { Notification } from "../domain/notification"

export interface NotificationRepository {
  list(): Promise<Notification[]>
  markRead(id: string): Promise<Notification | null>
  markAllRead(): Promise<void>
}
