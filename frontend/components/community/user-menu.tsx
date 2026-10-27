"use client"

import { Camera, ExternalLink, LogOut, Newspaper, PenLine, Sparkles, Trophy, User as UserIcon } from "lucide-react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { useTransition, type ReactNode } from "react"

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import { levelName, type User } from "@/modules/users/domain/user"
import { logoutAction } from "@/modules/auth/presentation/auth.actions"
import { useDialogs } from "./dialogs/dialogs-context"
import { SiteLink } from "./site-link"
import { UserAvatar } from "./user-avatar"

export function UserMenu({
  user,
  trigger,
  className,
  side = "bottom",
}: {
  user: User
  trigger: ReactNode
  className?: string
  side?: "bottom" | "top"
}) {
  const router = useRouter()
  const { openBlogEditor, openPhoto, openProfileEditor } = useDialogs()
  const [, startTransition] = useTransition()

  const handleSignOut = () =>
    startTransition(async () => {
      await logoutAction()
      router.push("/")
      router.refresh()
    })

  return (
    <DropdownMenu>
      <DropdownMenuTrigger className={className} aria-label="Mon compte">
        {trigger}
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" side={side} sideOffset={8} className="w-[270px]">
        <div className="-mx-1.5 -mt-1.5 mb-1.5 flex items-center gap-2.5 border-b border-hairline px-4 py-3.5">
          <UserAvatar user={user} size="md" />
          <div>
            <b className="font-semibold">{user.name}</b>
            <div className="text-[13px] text-ink-3">
              {levelName(user.points)} · <span className="tabular-nums">{user.points}</span> pts
            </div>
          </div>
        </div>
        <DropdownMenuItem render={<Link href={`/membres/${user.username}`} />}>
          <UserIcon />
          Mon profil et mes badges
        </DropdownMenuItem>
        <DropdownMenuItem onClick={openBlogEditor}>
          <PenLine />
          Écrire un billet
        </DropdownMenuItem>
        <DropdownMenuItem onClick={openPhoto}>
          <Camera />
          Changer ma photo
        </DropdownMenuItem>
        <DropdownMenuItem render={<Link href="/classement" />}>
          <Trophy />
          Classement
        </DropdownMenuItem>
        <DropdownMenuItem onClick={openProfileEditor}>
          <Sparkles />
          Pseudo et centres d&apos;intérêt
        </DropdownMenuItem>
        <DropdownMenuItem render={<SiteLink />}>
          <Newspaper />
          Retour sur lerevenu.com
          <ExternalLink className="ml-auto size-3.5 opacity-60" />
        </DropdownMenuItem>
        <DropdownMenuItem onClick={handleSignOut}>
          <LogOut />
          Se déconnecter
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  )
}
