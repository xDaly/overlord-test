"use server"

import { revalidatePath } from "next/cache"

import { community } from "@/modules/community/community.container"
import { getSessionUser } from "@/modules/community/presentation/session"
import type { Notification } from "../domain/notification"

export async function openNotificationAction(id: string): Promise<Notification | null> {
  const user = await getSessionUser()
  if (!user) return null
  const notification = await community().notifications.markRead(id)
  revalidatePath("/", "layout")
  return notification
}

export async function markAllNotificationsReadAction(): Promise<void> {
  const user = await getSessionUser()
  if (!user) return
  await community().notifications.markAllRead()
  revalidatePath("/", "layout")
}
