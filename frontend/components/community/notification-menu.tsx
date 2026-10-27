"use client"

import { Bell, Calendar, Check, MessageCircle, Star, ThumbsUp, Trophy, type LucideIcon } from "lucide-react"
import { useRouter } from "next/navigation"
import { useTransition, type ReactNode } from "react"

import { Button } from "@/components/ui/button"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { cn } from "@/lib/utils"
import { formatRelativeTime } from "@/lib/format/relative-time"
import type { Notification } from "@/modules/notifications/domain/notification"
import {
  markAllNotificationsReadAction,
  openNotificationAction,
} from "@/modules/notifications/presentation/notification.actions"
import type { User } from "@/modules/users/domain/user"
import { BadgeIcon } from "./badge-icon"
import { NotePin } from "./notes"
import { UserAvatar } from "./user-avatar"

const KINDS: Record<Notification["kind"], { tint: string; icon: LucideIcon }> = {
  reply: { tint: "bg-brand-soft text-brand-text", icon: MessageCircle },
  like: { tint: "bg-brand-soft text-brand-text", icon: ThumbsUp },
  mention: { tint: "bg-brand-soft text-brand-text", icon: MessageCircle },
  badge: { tint: "bg-brand-soft text-brand-text", icon: Star },
  solution: { tint: "bg-ok-soft text-ok", icon: Check },
  level: { tint: "bg-brand-soft text-brand-text", icon: Trophy },
  event: { tint: "bg-ok-soft text-ok", icon: Calendar },
}

export function NotificationMenu({
  notifications,
  actors,
  profileHref,
  trigger,
  className,
  side = "bottom",
}: {
  notifications: Notification[]
  actors: Record<string, User>
  profileHref: string
  trigger: ReactNode
  className?: string
  side?: "bottom" | "top"
}) {
  const router = useRouter()
  const [, startTransition] = useTransition()

  const open = (notification: Notification) =>
    startTransition(async () => {
      await openNotificationAction(notification.id)
      if (notification.discussionId) router.push(`/discussions/${notification.discussionId}`)
      else if (notification.blogId) router.push(`/billets/${notification.blogId}`)
      else if (notification.kind === "badge" || notification.kind === "level") router.push(profileHref)
      else router.refresh()
    })

  const readAll = () =>
    startTransition(async () => {
      await markAllNotificationsReadAction()
      router.refresh()
    })

  return (
    <DropdownMenu>
      <DropdownMenuTrigger className={className} aria-label="Notifications">
        {trigger}
      </DropdownMenuTrigger>
      <DropdownMenuContent
        align="end"
        side={side}
        sideOffset={8}
        className="w-[min(380px,calc(100vw-32px))] overflow-hidden p-0"
      >
        <div className="flex items-center justify-between border-b border-hairline px-4 py-3">
          <b className="text-[15px] font-semibold">
            Notifications <NotePin k="follow" />
          </b>
          <Button variant="link" className="h-auto p-0 text-[13px] font-semibold text-brand-text" onClick={readAll}>
            Tout marquer comme lu
          </Button>
        </div>
        {notifications.length ? (
          notifications.map((notification) => {
            const actor = notification.actor ? actors[notification.actor] : undefined
            const { tint, icon: Icon } = KINDS[notification.kind]
            return (
              <DropdownMenuItem
                key={notification.id}
                onClick={() => open(notification)}
                className={cn(
                  "items-start gap-[11px] rounded-none border-t border-hairline px-4 py-3 text-sm leading-[1.4] first:border-t-0",
                  !notification.read && "bg-brand/6"
                )}
              >
                {actor ? (
                  <UserAvatar user={actor} size="sm" />
                ) : notification.kind === "badge" && notification.badge ? (
                  <BadgeIcon code={notification.badge} className="size-[30px]" />
                ) : (
                  <span className={cn("grid size-[30px] shrink-0 place-items-center rounded-full [&_svg]:size-[15px]", tint)}>
                    <Icon />
                  </span>
                )}
                <div>
                  {actor ? <b>{actor.name} </b> : null}
                  {notification.text}
                  <small className="mt-0.5 block text-xs text-ink-3">{formatRelativeTime(notification.createdAt)}</small>
                </div>
              </DropdownMenuItem>
            )
          })
        ) : (
          <div className="px-5 py-10 text-center text-ink-2">
            <p>Aucune notification pour l&apos;instant.</p>
          </div>
        )}
      </DropdownMenuContent>
    </DropdownMenu>
  )
}

export function BellTrigger({ unread }: { unread: number }) {
  return (
    <>
      <Bell className="size-[18px]" />
      {unread ? (
        <span className="pointer-events-none absolute top-0.5 left-[calc(50%+3px)] grid h-[17px] min-w-[17px] place-items-center rounded-[9px] bg-brand px-1 text-[10.5px] leading-none font-bold text-white tabular-nums shadow-[0_0_0_2px_var(--card),0_1px_2px_rgba(0,0,0,.25)]">
          {unread}
        </span>
      ) : null}
    </>
  )
}
