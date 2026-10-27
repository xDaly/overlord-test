import { AppError } from "@/lib/errors"
import type { CommunityDeps, UsefulResult } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export type ToggleBlogUsefulResult = UsefulResult

export async function toggleBlogUseful(
  deps: Pick<CommunityDeps, "blogs">,
  viewer: User | null,
  blogId: string,
  commentId: string | null
): Promise<ToggleBlogUsefulResult> {
  if (!viewer) throw new AppError("unauthenticated")
  const result = await deps.blogs.toggleLike(blogId, commentId)
  if (!result) throw new AppError("not-found")
  return result
}
