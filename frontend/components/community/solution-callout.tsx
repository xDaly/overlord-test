import { Check } from "lucide-react"

import type { Reply } from "@/modules/discussions/domain/discussion"
import { JumpButton } from "./discussion-actions"
import { NotePin } from "./notes"

export function SolutionCallout({ reply }: { reply: Reply }) {
  const excerpt = reply.content.replace(/\n+/g, " ").slice(0, 170)
  return (
    <div className="relative flex items-start gap-3 rounded-lg bg-ok-soft px-4 py-3.5 text-left">
      <JumpButton
        targetId={`r${reply.id}`}
        label="Aller à la meilleure réponse"
        className="absolute inset-0 h-full w-full rounded-lg hover:bg-transparent"
      />
      <Check className="mt-0.5 size-[18px] shrink-0 text-ok" />
      <div>
        <b className="font-semibold text-ok">Meilleure réponse</b>
        {reply.verified ? " · vérifiée par la rédaction" : ""} · {reply.author.name}{" "}
        <span className="relative z-10">
          <NotePin k="bestanswer" />
        </span>
        <p className="mt-0.5 text-sm text-ink-2">{excerpt}…</p>
      </div>
    </div>
  )
}
