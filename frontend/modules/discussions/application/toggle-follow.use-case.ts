import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export async function toggleFollow(
  deps: Pick<CommunityDeps, "discussions">,
  viewer: User | null,
  discussionId: string
): Promise<boolean> {
  if (!viewer) throw new AppError("unauthenticated")
  const followed = await deps.discussions.toggleFollow(discussionId)
  if (followed === null) throw new AppError("not-found")
  return followed
}
