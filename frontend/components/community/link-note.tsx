"use client"

import { Check, Shield } from "lucide-react"
import Link from "next/link"

import { cn } from "@/lib/utils"
import { analyzeLinks } from "@/modules/moderation/domain/links"
import { useCommunity } from "./community-context"
import { NotePin } from "./notes"

const BOX = "mt-1.5 flex items-start gap-2 rounded-lg px-2.5 py-2 text-[13px] leading-[1.45]"

export function LinkNote({ text }: { text: string }) {
  const { user } = useCommunity()
  if (!user) return null
  const { status, badHosts } = analyzeLinks(text, user)
  if (status === "none") return null
  if (status === "ok")
    return (
      <div aria-live="polite" className={cn(BOX, "bg-ok-soft text-ok")}>
        <Check className="mt-px size-4 shrink-0" />
        <span>Lien vers une source de confiance : il sera cliquable.</span>
      </div>
    )
  if (status === "warn")
    return (
      <div aria-live="polite" className={cn(BOX, "bg-sub/16 text-foreground")}>
        <Shield className="mt-px size-4 shrink-0" />
        <span>
          Le lien vers <b>{badHosts.join(", ")}</b> sera vérifié par la modération avant d&apos;être cliquable.{" "}
          <NotePin k="links" />
        </span>
      </div>
    )
  return (
    <div aria-live="polite" className={cn(BOX, "bg-alert-soft text-foreground")}>
      <Shield className="mt-px size-4 shrink-0 text-destructive" />
      <span>
        Les liens vers <b>{badHosts.join(", ")}</b> ne sont pas autorisés à votre niveau. Sont acceptés : lerevenu.com,
        les sites publics (.gouv.fr, service-public.fr), l&apos;AMF, la Banque de France, l&apos;Insee et la Cour des
        comptes.{" "}
        <Link href="/charte" className="font-semibold text-brand-text">
          Pourquoi ?
        </Link>{" "}
        <NotePin k="links" />
      </span>
    </div>
  )
}
