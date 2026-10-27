import type { Category } from "@/modules/categories/domain/category"
import type { CommunityDeps } from "./deps"

export type CommunityStats = {
  members: number
  discussions: number
  replies: number
  resolvedPercent: number | null
}

export async function getCommunityStats(
  deps: Pick<CommunityDeps, "users" | "discussions">,
  categories: Category[]
): Promise<CommunityStats> {
  const [users, questions] = await Promise.all([deps.users.list(), deps.discussions.questionStats()])
  return {
    members: users.filter((user) => user.role === "member").length,
    discussions: categories.reduce((sum, category) => sum + category.topicsCount, 0),
    replies: categories.reduce((sum, category) => sum + category.repliesCount, 0),
    resolvedPercent: questions.total > 0 ? Math.round((questions.solved * 100) / questions.total) : null,
  }
}
