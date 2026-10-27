import { AppError } from "@/lib/errors"
import type { CommunityDeps, MessageEffect } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export async function chooseSolution(
  deps: Pick<CommunityDeps, "discussions">,
  viewer: User | null,
  discussionId: string,
  replyId: string
): Promise<{ solutionId: string | null; effects: MessageEffect[] }> {
  if (!viewer) throw new AppError("unauthenticated")
  const discussion = await deps.discussions.findById(discussionId)
  if (!discussion) throw new AppError("not-found")
  if (discussion.type !== "question" || discussion.author.username !== viewer.username) throw new AppError("forbidden")

  const result = await deps.discussions.toggleSolution(discussionId, replyId)
  if (!result) throw new AppError("not-found")
  if (!result.solutionId || !result.answerer) return { solutionId: result.solutionId, effects: [] }
  return {
    solutionId: result.solutionId,
    effects: [
      {
        kind: "message",
        icon: "check",
        title: "Meilleure réponse choisie",
        text: `${result.answerer} reçoit +${result.points} points. Merci d'avoir clôturé votre question !`,
      },
    ],
  }
}
