import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import { analyzeLinks } from "@/modules/moderation/domain/links"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import type { Reply } from "../domain/discussion"
import { MIN_REPLY_LENGTH } from "../domain/discussion.rules"

export type PublishReplyResult = { reply: Reply; effects: Effect[]; mentioned: string[] }

export async function publishReply(
  deps: Pick<CommunityDeps, "discussions">,
  author: User | null,
  discussionId: string,
  content: string
): Promise<PublishReplyResult> {
  if (!author) throw new AppError("unauthenticated")
  const body = content.trim()
  if (body.length < MIN_REPLY_LENGTH) throw new AppError("validation", { content: "content.required" })
  if (analyzeLinks(body, author).status === "bad") throw new AppError("validation", { content: "content.links" })

  const published = await deps.discussions.addReply(discussionId, body)
  if (!published) throw new AppError("not-found")
  return { reply: published.item, effects: published.effects, mentioned: published.mentioned }
}
