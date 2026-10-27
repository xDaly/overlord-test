import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import { analyzeLinks } from "@/modules/moderation/domain/links"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import type { DiscussionDetail } from "../domain/discussion"
import { normalizeTitle, validateNewDiscussion, type NewDiscussionInput } from "../domain/discussion.rules"

export type CreateDiscussionResult = { discussion: DiscussionDetail; effects: Effect[] }

export async function createDiscussion(
  deps: Pick<CommunityDeps, "discussions">,
  author: User | null,
  input: NewDiscussionInput
): Promise<CreateDiscussionResult> {
  if (!author) throw new AppError("unauthenticated")
  const errors: Record<string, string> = { ...validateNewDiscussion(input) }
  if (analyzeLinks(input.content, author).status === "bad") errors.content = "content.links"
  if (Object.keys(errors).length) throw new AppError("validation", errors)

  const { item, effects } = await deps.discussions.create(author, {
    ...input,
    title: normalizeTitle(input.title),
    content: input.content.trim(),
    options: input.options?.map((option) => option.trim()).filter(Boolean),
  })
  return { discussion: item, effects }
}
