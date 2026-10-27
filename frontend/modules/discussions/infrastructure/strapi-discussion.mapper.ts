import type { Category } from "@/modules/categories/domain/category"
import { isExpert, type User } from "@/modules/users/domain/user"
import type { Discussion, DiscussionDetail, Reply } from "../domain/discussion"
import type { SeoInput } from "../domain/seo"
import type { StrapiDiscussionEntry, StrapiReplyEntry } from "./strapi-types"

const PARTICIPANTS_SHOWN = 4

export type MapContext = {
  viewerId: number | null
  user: (username: string) => User
  category: (slug: string, fallbackName?: string) => Category
}

const votesOf = (entry: { usefulBase: number; usefulBy?: { id: number }[] }) => entry.usefulBase + (entry.usefulBy?.length ?? 0)
const votedBy = (entry: { usefulBy?: { id: number }[] }, viewerId: number | null) =>
  viewerId !== null && (entry.usefulBy ?? []).some((member) => member.id === viewerId)

export function toReply(entry: StrapiReplyEntry, context: MapContext): Reply {
  return {
    id: entry.documentId,
    content: entry.content ?? "",
    createdAt: entry.createdAt,
    likes: votesOf(entry),
    liked: votedBy(entry, context.viewerId),
    verified: entry.verified,
    author: context.user(entry.author?.username ?? ""),
  }
}

function seoInput(entry: StrapiDiscussionEntry, context: MapContext, usefulTotal: number): SeoInput {
  const replies = entry.replies ?? []
  const people = [entry.author?.username ?? "", ...replies.map((reply) => reply.author?.username ?? "")].map(context.user)
  const expert = people.find(isExpert)
  const best = replies.find((reply) => reply.isBestAnswer)
  return {
    categorySlug: entry.category?.slug ?? "",
    usefulCount: usefulTotal,
    repliesCount: replies.length,
    solutionVerified: best ? best.verified : null,
    hasExpertParticipant: Boolean(expert),
    expertIsRedaction: expert?.role === "redaction",
  }
}

export function toDiscussion(entry: StrapiDiscussionEntry, context: MapContext): Discussion {
  const replies = entry.replies ?? []
  const options = entry.pollOptions
  const counts = entry.pollVotes?.counts ?? []
  const usefulTotal = votesOf(entry) + replies.reduce((sum, reply) => sum + votesOf(reply), 0)
  const seen = new Map<string, User>()
  for (const reply of replies) {
    const username = reply.author?.username ?? ""
    seen.delete(username)
    seen.set(username, context.user(username))
  }
  const participants = [...seen.values()].slice(-PARTICIPANTS_SHOWN)
  const lastReply = replies.map((reply) => reply.createdAt).sort().at(-1)
  const myVote = context.viewerId === null ? undefined : entry.pollVotes?.voters?.[String(context.viewerId)]

  return {
    id: entry.slug,
    title: entry.title,
    content: entry.content ?? "",
    type: entry.type,
    createdAt: entry.createdAt,
    lastActivityAt: lastReply && lastReply > entry.createdAt ? lastReply : entry.createdAt,
    likes: votesOf(entry),
    liked: votedBy(entry, context.viewerId),
    views: entry.views,
    pinned: entry.pinned,
    featured: entry.featured,
    article: entry.article,
    followed: context.viewerId !== null && (entry.followedBy ?? []).some((member) => member.id === context.viewerId),
    author: context.user(entry.author?.username ?? ""),
    category: context.category(entry.category?.slug ?? "", entry.category?.name),
    repliesCount: replies.length,
    participants,
    solutionId: replies.find((reply) => reply.isBestAnswer)?.documentId ?? null,
    options: options ? options.map((label, index) => ({ label, votes: counts[index] ?? 0 })) : null,
    myVote: myVote ?? null,
    usefulTotal,
    seo: seoInput(entry, context, usefulTotal),
  }
}

export function toDetail(entry: StrapiDiscussionEntry, context: MapContext): DiscussionDetail {
  return { ...toDiscussion(entry, context), replies: (entry.replies ?? []).map((reply) => toReply(reply, context)) }
}
