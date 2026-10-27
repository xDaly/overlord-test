import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import { MIN_REPLY_LENGTH } from "@/modules/discussions/domain/discussion.rules"
import { analyzeLinks } from "@/modules/moderation/domain/links"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import type { BlogComment } from "../domain/blog"

export type CommentBlogResult = { comment: BlogComment; effects: Effect[]; mentioned: string[] }

export async function commentBlog(
  deps: Pick<CommunityDeps, "blogs">,
  author: User | null,
  blogId: string,
  content: string
): Promise<CommentBlogResult> {
  if (!author) throw new AppError("unauthenticated")
  const body = content.trim()
  if (body.length < MIN_REPLY_LENGTH) throw new AppError("validation", { content: "content.required" })
  if (analyzeLinks(body, author).status === "bad") throw new AppError("validation", { content: "content.links" })

  const published = await deps.blogs.addComment(blogId, body)
  if (!published) throw new AppError("not-found")
  return { comment: published.item, effects: published.effects, mentioned: published.mentioned }
}
