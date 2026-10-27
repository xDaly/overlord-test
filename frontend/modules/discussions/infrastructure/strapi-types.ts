import type { DiscussionType } from "../domain/discussion"

export type StrapiMemberRef = { id: number; username?: string; displayName?: string | null }

export type StrapiReplyEntry = {
  id: number
  documentId: string
  content?: string
  isBestAnswer: boolean
  verified: boolean
  usefulBase: number
  createdAt: string
  author?: StrapiMemberRef | null
  usefulBy?: { id: number }[]
}

export type StrapiDiscussionEntry = {
  id: number
  documentId: string
  slug: string
  title: string
  content: string | null
  type: DiscussionType
  article: string | null
  pinned: boolean
  featured: "question" | "poll" | null
  views: number
  usefulBase: number
  pollOptions: string[] | null
  pollVotes: { counts: number[]; voters: Record<string, number> } | null
  createdAt: string
  author?: StrapiMemberRef | null
  category?: { slug: string; name: string } | null
  usefulBy?: { id: number }[]
  followedBy?: { id: number }[]
  replies?: StrapiReplyEntry[]
}
