"use client"

import { ChartColumn, ChevronRight, CircleHelp, MessageCircle, Newspaper, Plus, Search, Shield, X } from "lucide-react"
import Link from "next/link"
import { useActionState, useEffect, useRef, useState } from "react"

import { Button } from "@/components/ui/button"
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible"
import { Dialog, DialogContent, DialogFooter } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { clearDraft, readDraft, writeDraft } from "@/lib/drafts"
import type { ComposeState } from "@/modules/community/presentation/form-state"
import type { UiEffect } from "@/modules/community/presentation/action-result"
import type { DiscussionType } from "@/modules/discussions/domain/discussion"
import { MAX_OPTION_LENGTH, MAX_POLL_OPTIONS, MAX_TITLE_LENGTH, MIN_POLL_OPTIONS } from "@/modules/discussions/domain/discussion.rules"
import { findSimilar } from "@/modules/discussions/domain/feed"
import { createDiscussionAction } from "@/modules/discussions/presentation/discussion.actions"
import { messageFor } from "@/modules/discussions/presentation/messages"
import { useCommunity } from "../community-context"
import { FIELD_HINT, FIELD_LABEL, FieldError, ModalBody, ModalHead } from "../modal-parts"
import { MentionField } from "../mention-field"
import { NotePin, useNotes } from "../notes"

export type ComposerOptions = { type?: DiscussionType; category?: string; title?: string }

type Draft = { type: DiscussionType; title: string; category: string; content: string; options: string[] }

const DRAFT_KEY = "composer"

const TYPES = [
  { value: "question", icon: CircleHelp, label: "Poser une question", hint: "Obtenez l'aide des membres et de la rédaction" },
  { value: "discussion", icon: MessageCircle, label: "Lancer une discussion", hint: "Partagez une expérience, un avis, une actualité" },
  { value: "poll", icon: ChartColumn, label: "Créer un sondage", hint: "Recueillez l'avis de la communauté en un clic" },
] as const

const PLACEHOLDERS: Record<DiscussionType, string> = {
  question: "Ex. : Faut-il ouvrir un PER à 45 ans ?",
  discussion: "Ex. : Mon retour d'expérience sur la renégociation de mon crédit",
  poll: "Ex. : Combien de temps passez-vous à suivre vos placements ?",
}

export function ComposerDialog({
  open,
  options,
  onOpenChange,
  onCreated,
}: {
  open: boolean
  options: ComposerOptions
  onOpenChange: (open: boolean) => void
  onCreated: (created: { id: string; effects: UiEffect[] }) => void
}) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        {open ? <ComposerForm options={options} onClose={() => onOpenChange(false)} onCreated={onCreated} /> : null}
      </DialogContent>
    </Dialog>
  )
}

function ComposerForm({
  options,
  onClose,
  onCreated,
}: {
  options: ComposerOptions
  onClose: () => void
  onCreated: (created: { id: string; effects: UiEffect[] }) => void
}) {
  const { categories, similar } = useCommunity()
  const { enabled: notesEnabled } = useNotes()
  const [state, formAction, isPending] = useActionState<ComposeState, FormData>(createDiscussionAction, {})
  const errors = state.fieldErrors ?? {}

  const [draft] = useState<Draft>(() => {
    const saved = readDraft<Draft>(DRAFT_KEY)
    return {
      type: options.type ?? saved?.type ?? "question",
      title: options.title ?? saved?.title ?? "",
      category: options.category ?? saved?.category ?? "",
      content: saved?.content ?? "",
      options: saved?.options?.length ? saved.options : ["", ""],
    }
  })
  const [type, setType] = useState<DiscussionType>(draft.type)
  const [title, setTitle] = useState(draft.title)
  const [category, setCategory] = useState(draft.category)
  const [content, setContent] = useState(draft.content)
  const [choices, setChoices] = useState(draft.options)

  useEffect(() => {
    writeDraft(DRAFT_KEY, { type, title, category, content, options: choices } satisfies Draft)
  }, [type, title, category, content, choices])

  const handled = useRef<number>(0)
  useEffect(() => {
    const created = state.created
    if (!created || handled.current === created.at) return
    handled.current = created.at
    clearDraft(DRAFT_KEY)
    onCreated({ id: created.id, effects: created.effects })
  }, [state.created, onCreated])

  const similarFound = findSimilar(similar, title)
  const pollError = errors.options ? messageFor(errors.options) : undefined

  return (
    <form action={formAction} noValidate className="flex min-h-0 flex-col">
      <ModalHead title="Nouvelle publication" description="Publier une question, une discussion ou un sondage" />
      <ModalBody>
        <RadioGroup
          name="type"
          value={type}
          onValueChange={(value) => setType(value as DiscussionType)}
          aria-label="Type de publication"
          className="grid-cols-3 gap-2.5 max-[760px]:grid-cols-1"
        >
          {TYPES.map(({ value, icon: Icon, label, hint }) => (
            <Label
              key={value}
              className="relative flex cursor-pointer flex-col items-start gap-1 rounded-xl border-[1.5px] border-line p-3.5 hover:border-line-strong has-data-checked:border-brand has-data-checked:bg-brand-soft has-focus-visible:outline-2 has-focus-visible:outline-offset-2 has-focus-visible:outline-brand max-[760px]:flex-row max-[760px]:items-center max-[760px]:gap-2.5 max-[760px]:px-3 max-[760px]:py-[11px]"
            >
              <RadioGroupItem value={value} className="pointer-events-none absolute size-0 border-0 opacity-0" />
              <Icon className="mb-1 size-[22px] text-brand-text max-[760px]:mb-0" />
              <b className="text-[14.5px] font-semibold">{label}</b>
              <small className="text-[12.5px] leading-snug font-normal text-ink-3 max-[760px]:hidden">{hint}</small>
            </Label>
          ))}
        </RadioGroup>

        <div className="flex flex-col gap-1.5">
          <Label htmlFor="c-title" className={FIELD_LABEL}>
            Titre
          </Label>
          <Input
            id="c-title"
            name="title"
            value={title}
            onChange={(event) => setTitle(event.target.value)}
            maxLength={MAX_TITLE_LENGTH}
            autoComplete="off"
            placeholder={PLACEHOLDERS[type]}
            aria-invalid={Boolean(errors.title)}
            aria-describedby="c-title-hint"
          />
          {errors.title ? (
            <FieldError id="c-title-hint" message={messageFor(errors.title)} />
          ) : (
            <span id="c-title-hint" className={FIELD_HINT}>
              Un titre clair, formulé comme une question, obtient plus vite des réponses.
            </span>
          )}
        </div>

        {similarFound.length ? (
          <div className="rounded-[9px] bg-brand-soft px-3.5 py-3">
            <b className="flex items-center gap-1.5 text-[13.5px] font-semibold">
              <Search className="size-[18px]" />
              Ces discussions répondent peut-être déjà à votre question <NotePin k="similar" />
            </b>
            {similarFound.map((entry, index) => (
              <Link
                key={entry.id}
                href={`/discussions/${entry.id}`}
                onClick={onClose}
                className={`group/similar flex justify-between gap-2.5 border-brand-text/20 py-[7px] text-sm ${index === 0 ? "mt-1.5" : "border-t"}`}
              >
                <span className="group-hover/similar:underline">{entry.title}</span>
                <small className="whitespace-nowrap text-ink-3">
                  {entry.solved ? "Résolu · " : ""}
                  {entry.repliesCount} rép.
                </small>
              </Link>
            ))}
          </div>
        ) : notesEnabled ? (
          <div className={FIELD_HINT}>
            <NotePin k="similar" /> Tapez « PEA » ou « assurance-vie » dans le titre.
          </div>
        ) : null}

        <div className="flex flex-col gap-1.5">
          <Label htmlFor="c-cat" className={FIELD_LABEL}>
            Espace
          </Label>
          <Select
            name="category"
            value={category || null}
            onValueChange={(value) => setCategory(value ?? "")}
            items={categories.map((entry) => ({ value: entry.slug, label: entry.name }))}
          >
            <SelectTrigger id="c-cat" className="w-full" aria-invalid={Boolean(errors.category)}>
              <SelectValue placeholder="Choisissez un espace…" />
            </SelectTrigger>
            <SelectContent alignItemWithTrigger={false}>
              {categories.map((entry) => (
                <SelectItem key={entry.slug} value={entry.slug}>
                  {entry.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
          <FieldError message={messageFor(errors.category)} />
        </div>

        <div className="flex flex-col gap-1.5">
          <Label htmlFor="c-body" className={FIELD_LABEL}>
            Détails {type === "poll" ? <span className="font-normal text-ink-3">(facultatif)</span> : null}
          </Label>
          <MentionField
            id="c-body"
            name="content"
            rows={5}
            defaultValue={draft.content}
            onTextChange={setContent}
            invalid={Boolean(errors.content)}
            className="min-h-0"
            placeholder="Votre situation, ce que vous avez déjà envisagé… Plus le contexte est précis, meilleures sont les réponses."
            hint="Tapez @ pour citer un membre ou la rédaction"
          />
          <FieldError message={messageFor(errors.content)} />
        </div>

        {type === "poll" ? (
          <div className="flex flex-col gap-1.5">
            <span className={FIELD_LABEL}>Réponses possibles</span>
            <div className="flex flex-col gap-2">
              {choices.map((choice, index) => (
                <div key={index} className="flex gap-2">
                  <Input
                    name="option"
                    value={choice}
                    onChange={(event) =>
                      setChoices((current) => current.map((entry, i) => (i === index ? event.target.value : entry)))
                    }
                    placeholder={`Réponse ${index + 1}`}
                    maxLength={MAX_OPTION_LENGTH}
                    aria-label={`Réponse ${index + 1}`}
                    className="flex-1"
                  />
                  {index >= MIN_POLL_OPTIONS ? (
                    <Button
                      variant="ghost"
                      size="icon"
                      aria-label="Retirer cette réponse"
                      onClick={() => setChoices((current) => current.filter((_, i) => i !== index))}
                    >
                      <X />
                    </Button>
                  ) : null}
                </div>
              ))}
            </div>
            <FieldError message={pollError} />
            {choices.length < MAX_POLL_OPTIONS ? (
              <Button variant="ghost" size="sm" className="self-start" onClick={() => setChoices((current) => [...current, ""])}>
                <Plus />
                Ajouter une réponse
              </Button>
            ) : null}
          </div>
        ) : null}

        <Collapsible>
          <CollapsibleTrigger className="group/trigger flex cursor-pointer items-center gap-1.5 text-sm font-semibold text-brand-text">
            <Newspaper className="size-[18px]" />
            Lier un article du Revenu
            <ChevronRight className="size-4 transition-transform group-data-panel-open/trigger:rotate-90" />
          </CollapsibleTrigger>
          <CollapsibleContent className="pt-2">
            <Input id="c-art" name="article" placeholder="https://www.lerevenu.com/…" aria-label="Adresse de l'article" />
          </CollapsibleContent>
        </Collapsible>

        <p className="flex items-start gap-2.5 rounded-[9px] bg-surface-2 px-3 py-2.5 text-[13px] text-ink-2">
          <Shield className="mt-px size-4 shrink-0 text-ink-3" />
          <span>
            Partagez votre expérience : pas de conseil personnalisé ni de sollicitation.{" "}
            <Link href="/charte" onClick={onClose} className="font-semibold text-brand-text">
              Lire la charte
            </Link>{" "}
            <NotePin k="compliance" />
          </span>
        </p>
        {state.formError ? (
          <p role="alert" className="text-[13px] text-destructive">
            {state.formError}
          </p>
        ) : null}
      </ModalBody>
      <DialogFooter>
        <span className={FIELD_HINT}>Brouillon enregistré automatiquement</span>
        <Button type="submit" disabled={isPending}>
          Publier
        </Button>
      </DialogFooter>
    </form>
  )
}
