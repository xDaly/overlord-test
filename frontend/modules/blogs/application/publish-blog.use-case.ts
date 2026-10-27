import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import { analyzeLinks } from "@/modules/moderation/domain/links"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import { validateNewBlog, type BlogPostDetail, type NewBlogInput } from "../domain/blog"

export type PublishBlogResult = { post: BlogPostDetail; effects: Effect[]; mentioned: string[] }

export async function publishBlog(
  deps: Pick<CommunityDeps, "blogs">,
  author: User | null,
  input: NewBlogInput
): Promise<PublishBlogResult> {
  if (!author) throw new AppError("unauthenticated")
  const errors: Record<string, string> = { ...validateNewBlog(input) }
  if (analyzeLinks(input.content, author).status === "bad") errors.content = "content.links"
  if (Object.keys(errors).length) throw new AppError("validation", errors)

  const { item, effects, mentioned } = await deps.blogs.create({
    title: input.title.trim().replace(/\s+/g, " "),
    content: input.content.trim(),
    categorySlug: input.categorySlug,
  })
  return { post: item, effects, mentioned }
}
