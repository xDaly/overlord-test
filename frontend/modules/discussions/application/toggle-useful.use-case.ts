import { AppError } from "@/lib/errors"
import type { CommunityDeps, UsefulResult } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export type ToggleUsefulResult = UsefulResult

export async function toggleUseful(
  deps: Pick<CommunityDeps, "discussions">,
  viewer: User | null,
  discussionId: string,
  replyId: string | null
): Promise<ToggleUsefulResult> {
  if (!viewer) throw new AppError("unauthenticated")
  const result = await deps.discussions.toggleLike(discussionId, replyId)
  if (!result) throw new AppError("not-found")
  return result
}
