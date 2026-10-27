import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import type { DiscussionDetail } from "../domain/discussion"

export async function getDiscussion(
  deps: Pick<CommunityDeps, "discussions">,
  id: string,
  viewer?: string
): Promise<DiscussionDetail> {
  const discussion = await deps.discussions.findById(id, viewer)
  if (!discussion) throw new AppError("not-found")
  return discussion
}
