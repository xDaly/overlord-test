import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export async function verifyReply(
  deps: Pick<CommunityDeps, "discussions">,
  viewer: User | null,
  discussionId: string,
  replyId: string
): Promise<boolean> {
  if (!viewer) throw new AppError("unauthenticated")
  const verified = await deps.discussions.toggleVerified(discussionId, replyId)
  if (verified === null) throw new AppError("not-found")
  return verified
}
