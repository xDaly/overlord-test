"use client"

import { Plus } from "lucide-react"

import { Button } from "@/components/ui/button"
import type { FeedTab } from "@/modules/discussions/domain/feed"
import { useDialogs } from "./dialogs/dialogs-context"

export function EmptyFeed({ tab, category }: { tab: FeedTab; category?: string }) {
  const { openComposer } = useDialogs()
  const unanswered = tab === "sans-reponse"
  return (
    <div className="px-5 py-10 text-center text-ink-2">
      <h3 className="mb-1.5 font-display text-xl font-bold tracking-[-.01em] text-foreground">
        {unanswered ? "Toutes les questions ont une réponse" : "Rien ici pour l'instant"}
      </h3>
      <p>
        {unanswered
          ? "Bravo à la communauté ! Revenez plus tard ou posez à votre tour une question."
          : "Lancez la première discussion de cet espace."}
      </p>
      <Button className="mt-3.5" onClick={() => openComposer({ category })}>
        <Plus />
        Publier
      </Button>
    </div>
  )
}
