"use server"

import { revalidatePath } from "next/cache"

import { community } from "@/modules/community/community.container"
import { run, type ActionResult, type UiEffect } from "@/modules/community/presentation/action-result"
import type { BlogState, FormState } from "@/modules/community/presentation/form-state"
import { getSessionUser } from "@/modules/community/presentation/session"
import { commentBlog } from "../application/comment-blog.use-case"
import { publishBlog } from "../application/publish-blog.use-case"
import { toggleBlogUseful, type ToggleBlogUsefulResult } from "../application/toggle-blog-useful.use-case"

const text = (data: FormData, key: string) => String(data.get(key) ?? "")

export async function publishBlogAction(_previous: BlogState, data: FormData): Promise<BlogState> {
  const values = { title: text(data, "title"), category: text(data, "category"), content: text(data, "content") }
  const result = await run(async () => {
    const published = await publishBlog(community(), await getSessionUser(), {
      title: values.title,
      content: values.content,
      categorySlug: values.category && values.category !== "none" ? values.category : null,
    })
    return { data: published.post.id, effects: published.effects }
  })
  if (!result.ok)
    return result.error === "validation"
      ? { values, fieldErrors: result.fields }
      : { values, formError: "La publication a échoué. Réessayez dans un instant." }
  revalidatePath("/", "layout")
  return { created: { id: result.data, effects: result.effects, at: Date.now() } }
}

export async function commentBlogAction(blogId: string, _previous: FormState, data: FormData): Promise<FormState> {
  const deps = community()
  const result = await run(async () => {
    const commented = await commentBlog(deps, await getSessionUser(), blogId, text(data, "content"))
    const effects: UiEffect[] = [...commented.effects]
    if (commented.mentioned.length) {
      const names = commented.mentioned
      const who = names.length > 1 ? `${names.slice(0, -1).join(", ")} et ${names.at(-1)}` : names[0]
      effects.push({
        kind: "message",
        icon: "at",
        title: `${who} ${names.length > 1 ? "recevront" : "recevra"} une notification`,
        text: "Grâce à votre mention dans ce message.",
        delayMs: 1300,
      })
    }
    return { data: commented.comment.id, effects }
  })
  if (!result.ok)
    return result.error === "validation"
      ? { fieldErrors: result.fields }
      : { formError: "Le commentaire n'a pas pu être publié. Réessayez dans un instant." }
  revalidatePath(`/billets/${blogId}`)
  revalidatePath("/", "layout")
  return { sent: Date.now(), effects: result.effects }
}

export async function toggleBlogUsefulAction(
  blogId: string,
  commentId: string | null
): Promise<ActionResult<ToggleBlogUsefulResult>> {
  const result = await run(async () => ({ data: await toggleBlogUseful(community(), await getSessionUser(), blogId, commentId) }))
  if (result.ok) revalidatePath(`/billets/${blogId}`)
  return result
}
