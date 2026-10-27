"use client"

import { Plus, Search } from "lucide-react"
import Link from "next/link"

import { Button } from "@/components/ui/button"
import type { Notification } from "@/modules/notifications/domain/notification"
import type { User } from "@/modules/users/domain/user"
import { useCommunity } from "./community-context"
import { useDialogs } from "./dialogs/dialogs-context"
import { BellTrigger, NotificationMenu } from "./notification-menu"
import { UserAvatar } from "./user-avatar"
import { UserMenu } from "./user-menu"

export function HeaderActions({
  notifications,
  actors,
}: {
  notifications: Notification[]
  actors: Record<string, User>
}) {
  const { user } = useCommunity()
  const { openLogin, openComposer } = useDialogs()
  const searchButton = (
    <Button
      variant="ghost"
      size="icon"
      aria-label="Rechercher"
      nativeButton={false}
      render={<Link href="/recherche" />}
      className="hidden max-[860px]:inline-flex"
    >
      <Search />
    </Button>
  )

  if (!user)
    return (
      <div className="relative ml-auto flex items-center gap-2.5">
        {searchButton}
        <Button variant="ghost" onClick={openLogin}>
          Se connecter
        </Button>
        <Button className="max-[860px]:hidden" onClick={openLogin}>
          Rejoindre
        </Button>
      </div>
    )

  const unread = notifications.filter((notification) => !notification.read).length
  return (
    <div className="relative ml-auto flex items-center gap-2.5">
      {searchButton}
      <Button className="max-[860px]:hidden" onClick={() => openComposer()}>
        <Plus />
        Publier
      </Button>
      <NotificationMenu
        notifications={notifications}
        actors={actors}
        profileHref={`/membres/${user.username}`}
        className="relative inline-grid size-9 place-items-center rounded-[9px] text-ink-2 outline-none hover:bg-fill hover:text-foreground focus-visible:ring-3 focus-visible:ring-brand/45"
        trigger={<BellTrigger unread={unread} />}
      />
      <UserMenu
        user={user}
        className="flex items-center gap-2 rounded-full border border-hairline bg-card py-[3px] pr-2.5 pl-[3px] shadow-[0_1px_2px_rgba(0,0,0,.05)] outline-none hover:bg-surface-2 focus-visible:ring-3 focus-visible:ring-brand/45"
        trigger={
          <>
            <UserAvatar user={user} size="sm" />
            <span className="text-[12.5px] font-semibold text-brand-text tabular-nums max-[760px]:hidden">
              {user.points} pts
            </span>
          </>
        }
      />
    </div>
  )
}
