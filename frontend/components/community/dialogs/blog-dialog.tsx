"use client"

import { Shield } from "lucide-react"
import Link from "next/link"
import { useActionState, useEffect, useRef, useState } from "react"

import { Button } from "@/components/ui/button"
import { Dialog, DialogContent, DialogFooter } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { clearDraft, readDraft, writeDraft } from "@/lib/drafts"
import { publishBlogAction } from "@/modules/blogs/presentation/blog.actions"
import { MAX_BLOG_TITLE_LENGTH } from "@/modules/blogs/domain/blog"
import type { UiEffect } from "@/modules/community/presentation/action-result"
import type { BlogState } from "@/modules/community/presentation/form-state"
import { messageFor } from "@/modules/discussions/presentation/messages"
import { useCommunity } from "../community-context"
import { MentionField } from "../mention-field"
import { FIELD_HINT, FIELD_LABEL, FieldError, ModalBody, ModalHead } from "../modal-parts"
import { NotePin } from "../notes"

type Draft = { title: string; category: string; content: string }

const DRAFT_KEY = "blog"
const NO_THEME = "none"

export function BlogDialog({
  open,
  onOpenChange,
  onCreated,
}: {
  open: boolean
  onOpenChange: (open: boolean) => void
  onCreated: (created: { id: string; effects: UiEffect[] }) => void
}) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        {open ? <BlogForm onClose={() => onOpenChange(false)} onCreated={onCreated} /> : null}
      </DialogContent>
    </Dialog>
  )
}

function BlogForm({
  onClose,
  onCreated,
}: {
  onClose: () => void
  onCreated: (created: { id: string; effects: UiEffect[] }) => void
}) {
  const { categories } = useCommunity()
  const [state, formAction, isPending] = useActionState<BlogState, FormData>(publishBlogAction, {})
  const errors = state.fieldErrors ?? {}
  const [draft] = useState<Draft>(() => readDraft<Draft>(DRAFT_KEY) ?? { title: "", category: "", content: "" })
  const [title, setTitle] = useState(draft.title)
  const [category, setCategory] = useState(draft.category)
  const [content, setContent] = useState(draft.content)

  useEffect(() => {
    writeDraft(DRAFT_KEY, { title, category, content } satisfies Draft)
  }, [title, category, content])

  const handled = useRef(0)
  useEffect(() => {
    const created = state.created
    if (!created || handled.current === created.at) return
    handled.current = created.at
    clearDraft(DRAFT_KEY)
    onCreated({ id: created.id, effects: created.effects })
  }, [state.created, onCreated])

  return (
    <form action={formAction} noValidate className="flex min-h-0 flex-col">
      <ModalHead title="Nouveau billet" description="Publier un billet sur votre profil" pin={<NotePin k="blog" />} />
      <ModalBody>
        <p className="text-ink-3">Votre billet sera publié sur votre profil et proposé aux membres sur l&apos;accueil.</p>
        <div className="flex flex-col gap-1.5">
          <Label htmlFor="b-title" className={FIELD_LABEL}>
            Titre
          </Label>
          <Input
            id="b-title"
            name="title"
            value={title}
            onChange={(event) => setTitle(event.target.value)}
            maxLength={MAX_BLOG_TITLE_LENGTH}
            autoComplete="off"
            placeholder="Ex. : Mon bilan après cinq ans de versements programmés"
            aria-invalid={Boolean(errors.title)}
          />
          <FieldError message={messageFor(errors.title, "blog")} />
        </div>
        <div className="flex flex-col gap-1.5">
          <Label htmlFor="b-cat" className={FIELD_LABEL}>
            Thème <span className="font-normal text-ink-3">(facultatif)</span>
          </Label>
          <Select
            name="category"
            value={category || NO_THEME}
            onValueChange={(value) => setCategory(value && value !== NO_THEME ? value : "")}
            items={[{ value: NO_THEME, label: "Aucun thème" }, ...categories.map((entry) => ({ value: entry.slug, label: entry.name }))]}
          >
            <SelectTrigger id="b-cat" className="w-full">
              <SelectValue />
            </SelectTrigger>
            <SelectContent alignItemWithTrigger={false}>
              <SelectItem value={NO_THEME}>Aucun thème</SelectItem>
              {categories.map((entry) => (
                <SelectItem key={entry.slug} value={entry.slug}>
                  {entry.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div className="flex flex-col gap-1.5">
          <Label htmlFor="b-body" className={FIELD_LABEL}>
            Votre billet
          </Label>
          <MentionField
            id="b-body"
            name="content"
            rows={10}
            defaultValue={draft.content}
            onTextChange={setContent}
            invalid={Boolean(errors.content)}
            className="min-h-0"
            placeholder="Racontez votre expérience : le contexte, ce que vous avez fait, ce que vous en retenez."
            hint="**gras** · une ligne commençant par « - » crée une liste"
          />
          <FieldError message={messageFor(errors.content, "blog")} />
        </div>
        <p className="flex items-start gap-2.5 rounded-[9px] bg-surface-2 px-3 py-2.5 text-[13px] text-ink-2">
          <Shield className="mt-px size-4 shrink-0 text-ink-3" />
          <span>
            Racontez votre expérience : pas de conseil personnalisé ni de sollicitation.{" "}
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
          Publier le billet
        </Button>
      </DialogFooter>
    </form>
  )
}
