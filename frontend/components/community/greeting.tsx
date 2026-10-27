import { Flame } from "lucide-react"

import type { User } from "@/modules/users/domain/user"

export function Greeting({ user }: { user: User }) {
  return (
    <div className="flex flex-wrap items-center justify-between gap-3">
      <h1 className="font-display text-[26px] font-bold tracking-[-.01em]">Bonjour {user.name}</h1>
      {user.streak && user.streak > 1 ? (
        <span className="inline-flex items-center gap-1.5 rounded-full bg-brand-soft px-3 py-[5px] text-[13.5px] font-semibold text-brand-text">
          <Flame className="size-[18px]" />
          {user.streak} jours d&apos;affilée
        </span>
      ) : null}
    </div>
  )
}
