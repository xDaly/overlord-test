"use client"

import { Bell, House, LayoutGrid, Plus, User as UserIcon } from "lucide-react"
import Link from "next/link"
import { usePathname } from "next/navigation"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import type { Notification } from "@/modules/notifications/domain/notification"
import type { User } from "@/modules/users/domain/user"
import { useCommunity } from "./community-context"
import { useDialogs } from "./dialogs/dialogs-context"
import { NotePin } from "./notes"
import { NotificationMenu } from "./notification-menu"

const ITEM =
  "relative flex min-w-14 flex-col items-center gap-0.5 px-2 py-1 text-[11px] text-ink-3 outline-none"

export function BottomNav({
  notifications,
  actors,
}: {
  notifications: Notification[]
  actors: Record<string, User>
}) {
  const pathname = usePathname()
  const { user } = useCommunity()
  const { openLogin, openComposer } = useDialogs()
  const onHome = pathname === "/"
  const onSpaces = pathname.startsWith("/espaces")
  const onProfile = user ? pathname === `/membres/${user.username}` : false
  const unread = notifications.filter((notification) => !notification.read).length

  const ghost = cn(ITEM, "h-auto rounded-none font-normal hover:bg-transparent")

  return (
    <nav
      aria-label="Navigation mobile"
      className="fixed inset-x-0 bottom-0 z-[45] hidden items-center justify-around border-t border-hairline bg-glass px-2 pt-1.5 pb-[calc(6px+env(safe-area-inset-bottom,0px))] backdrop-blur-[20px] backdrop-saturate-[180%] max-[760px]:flex"
    >
      <Link href="/" className={cn(ITEM, onHome && "font-semibold text-brand-text")}>
        <House className="size-[18px]" />
        Accueil
      </Link>
      <Link href="/espaces" className={cn(ITEM, onSpaces && "font-semibold text-brand-text")}>
        <LayoutGrid className="size-[18px]" />
        Espaces
      </Link>
      <Button
        aria-label="Publier"
        onClick={() => openComposer()}
        className="-mt-[18px] size-12 rounded-full p-0 shadow-[inset_0_1px_0_rgba(255,255,255,.25),0_6px_16px_color-mix(in_srgb,var(--brand)_40%,transparent)] [&_svg:not([class*='size-'])]:size-6"
      >
        <Plus />
      </Button>
      {user ? (
        <NotificationMenu
          notifications={notifications}
          actors={actors}
          profileHref={`/membres/${user.username}`}
          side="top"
          className={ITEM}
          trigger={
            <>
              <Bell className="size-[18px]" />
              Activité
              {unread ? (
                <span className="pointer-events-none absolute top-0 left-[calc(50%+2px)] grid h-[17px] min-w-[17px] place-items-center rounded-[9px] bg-brand px-1 text-[10.5px] leading-none font-bold text-white tabular-nums shadow-[0_0_0_2px_var(--card),0_1px_2px_rgba(0,0,0,.25)]">
                  {unread}
                </span>
              ) : null}
            </>
          }
        />
      ) : (
        <Button variant="ghost" className={ghost} onClick={openLogin}>
          <Bell className="size-[18px]" />
          Activité
        </Button>
      )}
      {user ? (
        <Link href={`/membres/${user.username}`} className={cn(ITEM, onProfile && "font-semibold text-brand-text")}>
          <UserIcon className="size-[18px]" />
          Profil
        </Link>
      ) : (
        <Button variant="ghost" className={ghost} onClick={openLogin}>
          <UserIcon className="size-[18px]" />
          Connexion
        </Button>
      )}
      <span className="absolute -top-3 right-1.5">
        <NotePin k="mobile" />
      </span>
    </nav>
  )
}
