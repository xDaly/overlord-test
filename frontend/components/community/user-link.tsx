"use client"

import { BadgeCheck } from "lucide-react"
import Link from "next/link"
import type { ReactNode } from "react"

import { Button } from "@/components/ui/button"
import { HoverCard, HoverCardContent, HoverCardTrigger } from "@/components/ui/hover-card"
import { memberSince, type User } from "@/modules/users/domain/user"
import { RoleTags } from "./role-tags"
import { UserAvatar } from "./user-avatar"

const HOVER_DELAY = 400
const CLOSE_DELAY = 250

function Stat({ value, label }: { value: string; label: string }) {
  return (
    <span className="text-[11.5px] text-ink-3">
      <b className="block text-sm font-semibold text-foreground tabular-nums">{value}</b>
      {label}
    </span>
  )
}

function UserCard({ user }: { user: User }) {
  const member = user.role === "member"
  return (
    <div role="dialog" aria-label={`Fiche de ${user.name}`}>
      <div className="flex items-center gap-3">
        <UserAvatar user={user} size="lg" />
        <div>
          <b className="block text-[15.5px] font-semibold">{user.name}</b>
          <small className="text-[12.5px] text-ink-3">@{user.username}</small>
        </div>
      </div>
      <div className="mt-2.5 flex flex-wrap gap-1.5">
        <RoleTags user={user} />
      </div>
      {user.expertTitle ? (
        <p className="mt-2.5 flex items-start gap-2 rounded-[10px] bg-pro/10 px-2.5 py-2 text-[13px]">
          <BadgeCheck className="size-[18px] shrink-0 text-pro" />
          <span>
            <b className="block font-semibold">{user.expertTitle}</b>
            <small className="text-xs text-ink-3">Expertise vérifiée par l&apos;équipe du Revenu</small>
          </span>
        </p>
      ) : null}
      {user.bio ? <p className="mt-2.5 text-[13.5px] text-ink-2">{user.bio}</p> : null}
      {member ? (
        <div className="my-3 grid grid-cols-3 gap-2 border-y border-line py-2.5 text-center">
          <Stat value={memberSince(user)} label="membre depuis" />
          <Stat value={String(user.stats.replies)} label="réponses" />
          <Stat value={String(user.stats.solutions)} label="meilleures réponses" />
        </div>
      ) : (
        <div className="my-3 border-y border-line py-2.5 text-center">
          <Stat value="Compte officiel" label="géré par l'équipe du Revenu" />
        </div>
      )}
      <Button variant="secondary" size="sm" className="w-full" nativeButton={false} render={<Link href={`/membres/${user.username}`} />}>
        Voir le profil
      </Button>
    </div>
  )
}

export function UserLink({
  user,
  className,
  children,
}: {
  user: User
  className?: string
  children: ReactNode
}) {
  return (
    <HoverCard>
      <HoverCardTrigger
        delay={HOVER_DELAY}
        closeDelay={CLOSE_DELAY}
        render={<Link href={`/membres/${user.username}`} />}
        className={className}
      >
        {children}
      </HoverCardTrigger>
      <HoverCardContent align="start" sideOffset={8} className="z-[70] w-[300px] rounded-[14px] border border-hairline p-4 shadow-pop ring-0">
        <UserCard user={user} />
      </HoverCardContent>
    </HoverCard>
  )
}
