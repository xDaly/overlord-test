"use client"

import { Check } from "lucide-react"
import { useRouter } from "next/navigation"
import { useTransition } from "react"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import type { PollOption } from "@/modules/discussions/domain/discussion"
import { votePollAction } from "@/modules/discussions/presentation/discussion.actions"
import { useDialogs } from "./dialogs/dialogs-context"
import { useEffects } from "./effects"

const OPTION =
  "relative h-auto min-h-[42px] w-full justify-start gap-2.5 overflow-hidden rounded-[9px] border-line bg-card px-3 py-2 text-left text-sm font-medium text-foreground hover:border-brand hover:bg-card"

export function PollBox({
  discussionId,
  options,
  myVote,
}: {
  discussionId: string
  options: PollOption[]
  myVote: number | null
}) {
  const router = useRouter()
  const { requireLogin } = useDialogs()
  const { showEffects } = useEffects()
  const [isPending, startTransition] = useTransition()
  const total = options.reduce((sum, option) => sum + option.votes, 0)
  const voted = myVote !== null

  const vote = (index: number) =>
    requireLogin(() =>
      startTransition(async () => {
        if (index === myVote) return
        const result = await votePollAction(discussionId, index)
        if (result.ok) showEffects(result.effects)
        router.refresh()
      })
    )

  return (
    <div className="flex flex-col gap-[7px]">
      {options.map((option, index) => {
        const percent = total ? Math.round((option.votes * 100) / total) : 0
        const mine = myVote === index
        return (
          <Button
            key={option.label}
            variant="outline"
            disabled={isPending}
            onClick={() => vote(index)}
            className={cn(OPTION, voted && "border-transparent bg-fill hover:border-transparent hover:bg-fill", mine && "font-bold")}
          >
            {voted ? (
              <span
                className={cn(
                  "absolute inset-y-0 left-0 animate-grow",
                  mine ? "bg-brand/22" : "bg-foreground/8"
                )}
                style={{ width: `${percent}%` }}
              />
            ) : (
              <span className="size-4 shrink-0 rounded-full border-2 border-line-strong group-hover/button:border-brand" />
            )}
            <span className="relative flex min-w-0 flex-1 items-center gap-1.5">
              {mine ? <Check className="size-[15px] text-brand-text" /> : null}
              {option.label}
            </span>
            {voted ? <span className="relative text-[13px] font-semibold tabular-nums">{percent} %</span> : null}
          </Button>
        )
      })}
      <p className="mt-[3px] text-[12.5px] text-ink-3">
        <span className="tabular-nums">{total.toLocaleString("fr-FR")}</span> votes ·{" "}
        {voted ? "Touchez une autre réponse pour changer d'avis" : "Votez pour voir les résultats"}
      </p>
    </div>
  )
}
