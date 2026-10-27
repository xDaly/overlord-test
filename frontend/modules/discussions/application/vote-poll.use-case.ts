import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"

export async function votePoll(
  deps: Pick<CommunityDeps, "discussions">,
  voter: User | null,
  discussionId: string,
  optionIndex: number
): Promise<{ effects: Effect[] }> {
  if (!voter) throw new AppError("unauthenticated")
  const result = await deps.discussions.vote(discussionId, optionIndex)
  if (!result) throw new AppError("not-found")
  return { effects: result.effects }
}
