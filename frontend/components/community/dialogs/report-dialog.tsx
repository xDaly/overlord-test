"use client"

import { useState } from "react"

import { Button } from "@/components/ui/button"
import { Dialog, DialogContent, DialogFooter } from "@/components/ui/dialog"
import { Label } from "@/components/ui/label"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { useEffects } from "../effects"
import { ModalBody, ModalHead } from "../modal-parts"
import { NotePin } from "../notes"

const REASONS = [
  "Propos irrespectueux",
  "Publicité ou sollicitation",
  "Rumeur de marché ou incitation à acheter ou vendre",
  "Informations personnelles exposées",
  "Autre motif",
]

export function ReportDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { showEffects } = useEffects()
  const [reason, setReason] = useState("0")

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[440px]">
        <form
          onSubmit={(event) => {
            event.preventDefault()
            onOpenChange(false)
            showEffects([
              {
                kind: "message",
                icon: "shield",
                title: "Signalement envoyé",
                text: "Merci, l'équipe de modération va examiner ce message.",
              },
            ])
          }}
        >
          <ModalHead title="Signaler ce message" description="Choisir le motif du signalement" pin={<NotePin k="report" />} />
          <ModalBody>
            <p className="text-ink-3">Votre signalement est anonyme. L&apos;équipe de modération l&apos;examine rapidement.</p>
            <RadioGroup name="reason" value={reason} onValueChange={setReason} className="gap-2">
              {REASONS.map((label, index) => (
                <Label
                  key={label}
                  className="flex cursor-pointer items-center gap-2.5 rounded-[9px] border border-line px-3 py-2.5 text-[14.5px] font-normal has-data-checked:border-brand has-data-checked:bg-brand-soft"
                >
                  <RadioGroupItem value={String(index)} />
                  {label}
                </Label>
              ))}
            </RadioGroup>
          </ModalBody>
          <DialogFooter>
            <Button type="button" variant="ghost" onClick={() => onOpenChange(false)}>
              Annuler
            </Button>
            <Button type="submit">Envoyer le signalement</Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}
