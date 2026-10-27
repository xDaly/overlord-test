import type { Category } from "@/modules/categories/domain/category"
import type { User } from "@/modules/users/domain/user"
import type { FeedTab } from "./feed"
import type { SeoInput } from "./seo"

export const DISCUSSION_TYPES = ["question", "discussion", "poll"] as const
export type DiscussionType = (typeof DISCUSSION_TYPES)[number]

export type PollOption = { label: string; votes: number }

export type Reply = {
  id: string
  content: string
  createdAt: string
  likes: number
  liked: boolean
  verified: boolean
  author: User
}

export type Discussion = {
  id: string
  title: string
  content: string
  type: DiscussionType
  createdAt: string
  lastActivityAt: string
  likes: number
  liked: boolean
  views: number
  pinned: boolean
  featured: "question" | "poll" | null
  article: string | null
  followed: boolean
  author: User
  category: Category
  repliesCount: number
  participants: User[]
  solutionId: string | null
  options: PollOption[] | null
  myVote: number | null
  usefulTotal: number
  seo: SeoInput
}

export type DiscussionDetail = Discussion & { replies: Reply[] }

export type DiscussionOrder = "newest" | "oldest"

export type ListDiscussionsQuery = {
  categorySlug?: string
  tab?: FeedTab
  order?: DiscussionOrder
  search?: string
  viewer?: User | null
  page?: number
  pageSize?: number
}

export type Page<T> = {
  items: T[]
  page: number
  pageCount: number
  total: number
}

export const totalVotes = (discussion: Pick<Discussion, "options">) =>
  (discussion.options ?? []).reduce((sum, option) => sum + option.votes, 0)
