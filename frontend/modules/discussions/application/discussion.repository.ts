import type { Published, UsefulResult } from "@/modules/community/application/deps"
import type { Effect } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import type {
  Discussion,
  DiscussionDetail,
  ListDiscussionsQuery,
  Page,
  Reply,
} from "../domain/discussion"
import type { NewDiscussionInput } from "../domain/discussion.rules"
import type { SimilarCandidate } from "../domain/feed"

export type VoteResult = { first: boolean; effects: Effect[] }
export type SolutionResult = { solutionId: string | null; answerer: string | null; points: number }
export type AuthoredReply = { discussionId: string; discussionTitle: string; content: string; isSolution: boolean }

export interface DiscussionRepository {
  list(query: ListDiscussionsQuery): Promise<Page<Discussion>>
  countUnanswered(categorySlug?: string): Promise<number>
  questionStats(): Promise<{ total: number; solved: number }>
  findById(id: string, viewer?: string): Promise<DiscussionDetail | null>
  search(text: string, viewer?: string): Promise<Discussion[]>
  listByAuthor(username: string, viewer?: string): Promise<Discussion[]>
  listRepliesBy(username: string): Promise<AuthoredReply[]>
  featured(kind: "question" | "poll", viewer?: string): Promise<Discussion | null>
  similarCandidates(): Promise<SimilarCandidate[]>
  create(author: User, input: NewDiscussionInput): Promise<Published<DiscussionDetail>>
  addReply(discussionId: string, content: string): Promise<Published<Reply> | null>
  toggleLike(discussionId: string, replyId: string | null): Promise<UsefulResult | null>
  toggleFollow(discussionId: string): Promise<boolean | null>
  vote(discussionId: string, optionIndex: number): Promise<VoteResult | null>
  toggleSolution(discussionId: string, replyId: string): Promise<SolutionResult | null>
  toggleVerified(discussionId: string, replyId: string): Promise<boolean | null>
}
