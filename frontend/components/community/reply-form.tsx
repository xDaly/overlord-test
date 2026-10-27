"use client"

import { useActionState, useCallback, useEffect } from "react"

import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { Label } from "@/components/ui/label"
import { clearDraft } from "@/lib/drafts"
import type { FormState } from "@/modules/community/presentation/form-state"
import { messageFor } from "@/modules/discussions/presentation/messages"
import type { User } from "@/modules/users/domain/user"
import { useEffects } from "./effects"
import { MentionField } from "./mention-field"
import { NotePin } from "./notes"
import { UserAvatar } from "./user-avatar"

export type ReplyAction = (previous: FormState, data: FormData) => Promise<FormState>

export function ReplyForm({
  action,
  draftKey,
  author,
  verb,
  placeholder,
  submitLabel,
  participants,
}: {
  action: ReplyAction
  draftKey: string
  author: User
  verb: "Répondre" | "Commenter"
  placeholder: string
  submitLabel: string
  participants: string[]
}) {
  const { showEffects } = useEffects()
  const submit = useCallback<ReplyAction>(
    async (previous, form) => {
      const next = await action(previous, form)
      if (next.sent) clearDraft(draftKey)
      return next
    },
    [action, draftKey]
  )
  const [state, formAction, isPending] = useActionState<FormState, FormData>(submit, {})
  const error = messageFor(state.fieldErrors?.content) ?? state.formError

  useEffect(() => {
    if (!state.sent) return
    showEffects(state.effects ?? [])
    const id = setTimeout(() => {
      const replies = document.querySelectorAll<HTMLElement>("[data-reply]")
      const latest = replies[replies.length - 1]
      latest?.scrollIntoView({ behavior: "smooth", block: "center" })
      latest?.classList.add("animate-flash")
    }, 500)
    return () => clearTimeout(id)
  }, [state.sent, state.effects, showEffects])

  useEffect(() => {
    if (window.location.hash !== "#repondre") return
    const field = document.getElementById("reply-body")
    field?.scrollIntoView({ behavior: "smooth", block: "center" })
    field?.focus({ preventScroll: true })
  }, [])

  return (
    <Card className="px-5 py-4 max-[760px]:p-4" id="repondre">
      <form key={state.sent ?? 0} action={formAction} noValidate className="flex flex-col gap-2.5">
        <div className="flex items-center gap-[11px]">
          <UserAvatar user={author} size="sm" />
          <div className="text-[12.5px] text-ink-3">
            {verb === "Répondre" ? "Répondre" : "Commenter"} en tant que <b className="text-foreground">{author.name}</b>{" "}
            {verb === "Répondre" ? <NotePin k="replybox" /> : null}
          </div>
        </div>
        <Label htmlFor="reply-body" className="sr-only">
          {verb === "Répondre" ? "Votre réponse" : "Votre commentaire"}
        </Label>
        <MentionField
          id="reply-body"
          name="content"
          draftKey={draftKey}
          participants={participants}
          placeholder={placeholder}
          invalid={Boolean(error)}
          hint="ou tapez @ · Ctrl + Entrée pour publier"
        />
        {error ? (
          <p role="alert" className="text-[13px] text-destructive">
            {error}
          </p>
        ) : null}
        <div className="flex flex-wrap items-center justify-end gap-2.5">
          <Button type="submit" disabled={isPending}>
            {submitLabel}
          </Button>
        </div>
      </form>
    </Card>
  )
}
