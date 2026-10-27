"use client"

import { ChartColumn, CircleHelp, MessageCircle, User as UserIcon } from "lucide-react"

import { Button } from "@/components/ui/button"
import type { DiscussionType } from "@/modules/discussions/domain/discussion"
import { useCommunity } from "./community-context"
import { useDialogs } from "./dialogs/dialogs-context"
import { NotePin } from "./notes"
import { UserAvatar } from "./user-avatar"

const TYPES: { type: DiscussionType; label: string; icon: typeof CircleHelp }[] = [
  { type: "question", label: "Question", icon: CircleHelp },
  { type: "discussion", label: "Discussion", icon: MessageCircle },
  { type: "poll", label: "Sondage", icon: ChartColumn },
]

export function QuickComposer({ category }: { category?: string }) {
  const { user } = useCommunity()
  const { openComposer } = useDialogs()
  return (
    <div
      role="group"
      className="flex w-full items-center gap-3 rounded-lg border border-hairline bg-card px-3 py-2.5 shadow-card"
    >
      {user ? (
        <UserAvatar user={user} size="md" />
      ) : (
        <span className="grid size-10 shrink-0 place-items-center rounded-full bg-ink-3 text-white">
          <UserIcon className="size-[18px]" />
        </span>
      )}
      <Button
        variant="ghost"
        className="h-auto min-w-0 flex-1 justify-start overflow-hidden rounded-[10px] bg-fill px-3.5 py-[9px] font-normal text-ellipsis whitespace-nowrap text-ink-3 hover:bg-fill hover:text-ink-3"
        onClick={() => openComposer({ type: "question", category })}
      >
        Posez votre question à la communauté…
      </Button>
      <div className="flex gap-1 max-[760px]:hidden">
        {TYPES.map(({ type, label, icon: Icon }) => (
          <Button
            key={type}
            variant="ghost"
            className="h-auto rounded-[9px] px-2.5 py-[7px] text-[13.5px] font-medium"
            onClick={() => openComposer({ type, category })}
          >
            <Icon />
            {label}
          </Button>
        ))}
      </div>
      <NotePin k="composer" />
    </div>
  )
}
