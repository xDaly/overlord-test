"use client"

import { Check } from "lucide-react"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { useCommunity } from "./community-context"
import { useDialogs } from "./dialogs/dialogs-context"
import { NotePin } from "./notes"

const BENEFITS = [
  "Posez vos questions d'argent à des milliers de lecteurs",
  "Recevez les réponses de la rédaction",
  "Gagnez des badges en aidant les autres",
]

export function JoinCard() {
  const { user } = useCommunity()
  const { openLogin } = useDialogs()
  if (user) return null
  return (
    <Card className="bg-gradient-to-b from-brand-soft to-card to-70%">
      <CardContent>
        <h3 className="mb-1.5 font-display text-[19px] font-bold tracking-[-.01em]">
          Rejoignez la communauté <NotePin k="visitor" />
        </h3>
        <p className="text-sm text-ink-2">Avec votre compte lerevenu.com, gratuitement.</p>
        <ul className="mt-2.5 mb-3.5 flex flex-col gap-1.5 text-sm text-ink-2">
          {BENEFITS.map((benefit) => (
            <li key={benefit} className="flex items-start gap-2">
              <Check className="mt-0.5 size-4 shrink-0 text-brand-text" />
              {benefit}
            </li>
          ))}
        </ul>
        <Button className="w-full" onClick={openLogin}>
          Rejoindre la communauté
        </Button>
      </CardContent>
    </Card>
  )
}
