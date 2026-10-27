"use client"

import { Check } from "lucide-react"
import { useRouter } from "next/navigation"
import { useTransition } from "react"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import { toggleRsvpAction } from "@/modules/events/presentation/event.actions"
import { useDialogs } from "./dialogs/dialogs-context"
import { useEffects } from "./effects"

export function EventRsvpButton({ eventId, joined }: { eventId: string; joined: boolean }) {
  const router = useRouter()
  const { requireLogin } = useDialogs()
  const { showEffects } = useEffects()
  const [isPending, startTransition] = useTransition()

  const toggle = () =>
    requireLogin(() =>
      startTransition(async () => {
        const result = await toggleRsvpAction(eventId)
        if (result.ok) showEffects(result.effects)
        router.refresh()
      })
    )

  return (
    <Button
      size="sm"
      variant="secondary"
      disabled={isPending}
      onClick={toggle}
      className={cn(joined && "border-transparent bg-ok-soft text-ok shadow-none hover:bg-ok-soft")}
    >
      {joined ? <Check /> : null}
      {joined ? "Inscrit" : "Je participe"}
    </Button>
  )
}
