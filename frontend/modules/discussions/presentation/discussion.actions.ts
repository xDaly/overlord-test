"use server"

import { revalidatePath } from "next/cache"

import { community } from "@/modules/community/community.container"
import { run, type ActionResult, type UiEffect } from "@/modules/community/presentation/action-result"
import type { ComposeState, FormState } from "@/modules/community/presentation/form-state"
import { getSessionUser } from "@/modules/community/presentation/session"
import { chooseSolution } from "../application/choose-solution.use-case"
import { createDiscussion } from "../application/create-discussion.use-case"
import { publishReply } from "../application/publish-reply.use-case"
import { toggleFollow } from "../application/toggle-follow.use-case"
import { toggleUseful, type ToggleUsefulResult } from "../application/toggle-useful.use-case"
import { verifyReply } from "../application/verify-reply.use-case"
import { votePoll } from "../application/vote-poll.use-case"
import type { DiscussionType } from "../domain/discussion"

const text = (data: FormData, key: string) => String(data.get(key) ?? "")

const toFormError = (code: string) =>
  code === "unauthenticated" ? "Connectez-vous pour publier." : "L'action a échoué. Réessayez dans un instant."

export async function createDiscussionAction(_previous: ComposeState, data: FormData): Promise<ComposeState> {
  const values = {
    type: text(data, "type"),
    title: text(data, "title"),
    category: text(data, "category"),
    content: text(data, "content"),
    options: data.getAll("option").map(String),
    article: text(data, "article"),
  }
  const deps = community()
  const result = await run(async () => {
    const created = await createDiscussion(deps, await getSessionUser(), {
      title: values.title,
      content: values.content,
      type: values.type as DiscussionType,
      categorySlug: values.category,
      options: values.options,
      article: values.article.trim() || undefined,
    })
    return { data: created.discussion.id, effects: created.effects }
  })
  if (!result.ok)
    return result.error === "validation"
      ? { values, fieldErrors: result.fields }
      : { values, formError: toFormError(result.error) }
  revalidatePath("/", "layout")
  return { created: { id: result.data, effects: result.effects, at: Date.now() } }
}

export async function publishReplyAction(
  discussionId: string,
  _previous: FormState,
  data: FormData
): Promise<FormState> {
  const deps = community()
  const result = await run(async () => {
    const published = await publishReply(deps, await getSessionUser(), discussionId, text(data, "content"))
    const effects: UiEffect[] = [...published.effects]
    if (published.mentioned.length) {
      const names = published.mentioned
      const who = names.length > 1 ? `${names.slice(0, -1).join(", ")} et ${names.at(-1)}` : names[0]
      effects.push({
        kind: "message",
        icon: "at",
        title: `${who} ${names.length > 1 ? "recevront" : "recevra"} une notification`,
        text: "Grâce à votre mention dans ce message.",
        delayMs: 1300,
      })
    }
    return { data: published.reply.id, effects }
  })
  if (!result.ok)
    return result.error === "validation"
      ? { fieldErrors: result.fields }
      : { formError: result.error === "not-found" ? "Cette discussion n'existe plus." : toFormError(result.error) }
  revalidatePath(`/discussions/${discussionId}`)
  revalidatePath("/", "layout")
  return { sent: Date.now(), effects: result.effects }
}

export async function toggleUsefulAction(
  discussionId: string,
  replyId: string | null
): Promise<ActionResult<ToggleUsefulResult>> {
  const result = await run(async () => ({ data: await toggleUseful(community(), await getSessionUser(), discussionId, replyId) }))
  if (result.ok) revalidatePath(`/discussions/${discussionId}`)
  return result
}

export async function toggleFollowAction(discussionId: string): Promise<ActionResult<{ followed: boolean }>> {
  const result = await run(async () => ({
    data: { followed: await toggleFollow(community(), await getSessionUser(), discussionId) },
  }))
  if (result.ok) revalidatePath(`/discussions/${discussionId}`)
  return result
}

export async function votePollAction(discussionId: string, optionIndex: number): Promise<ActionResult> {
  const result = await run(async () => {
    const voted = await votePoll(community(), await getSessionUser(), discussionId, optionIndex)
    return { data: undefined, effects: voted.effects }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}

export async function chooseSolutionAction(
  discussionId: string,
  replyId: string
): Promise<ActionResult<{ solutionId: string | null }>> {
  const result = await run(async () => {
    const chosen = await chooseSolution(community(), await getSessionUser(), discussionId, replyId)
    return { data: { solutionId: chosen.solutionId }, effects: chosen.effects }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}

export async function verifyReplyAction(
  discussionId: string,
  replyId: string
): Promise<ActionResult<{ verified: boolean }>> {
  const result = await run(async () => {
    const verified = await verifyReply(community(), await getSessionUser(), discussionId, replyId)
    const effects: UiEffect[] = verified
      ? [
          {
            kind: "message",
            icon: "verified",
            title: "Réponse validée par la rédaction",
            text: "La mention s'affiche sous la réponse et renforce son référencement.",
          },
        ]
      : []
    return { data: { verified }, effects }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}
