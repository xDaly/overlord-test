import type { DiscussionType } from "./discussion"

export type FeedTab = "pour-vous" | "tendances" | "recentes" | "sans-reponse"

export type FeedItem = {
  id: string
  title: string
  type: DiscussionType
  categorySlug: string
  authorUsername: string
  createdAt: string
  lastActivityAt: string
  likes: number
  views: number
  pinned: boolean
  featured: boolean
  repliesCount: number
  pollVotes: number
  solved: boolean
}

export type FeedContext = {
  tab: FeedTab
  categorySlug?: string
  viewer?: string
  interests?: string[]
}

const MINUTE = 60_000

export function hotScore(item: FeedItem, now: Date = new Date()): number {
  const age = (now.getTime() - new Date(item.createdAt).getTime()) / MINUTE
  const lastAge = (now.getTime() - new Date(item.lastActivityAt).getTime()) / MINUTE
  const score = 1 + item.repliesCount * 3 + item.likes * 2 + item.views / 25 + item.pollVotes / 20
  return score / Math.pow((age + lastAge) / 120 + 2, 1.3)
}

const newestFirst = (a: FeedItem, b: FeedItem) => b.createdAt.localeCompare(a.createdAt)

export function selectFeed(items: FeedItem[], context: FeedContext, now: Date = new Date()): FeedItem[] {
  const { tab, categorySlug, viewer, interests = [] } = context
  let list = items.filter((item) => !categorySlug || item.categorySlug === categorySlug)

  if (tab === "pour-vous" && viewer && interests.length) {
    list = list.filter(
      (item) => interests.includes(item.categorySlug) || item.featured || item.authorUsername === viewer
    )
  }
  if (tab === "sans-reponse") {
    return list.filter((item) => item.repliesCount === 0 && item.type !== "poll").sort(newestFirst)
  }

  list = tab === "recentes" ? [...list].sort(newestFirst) : [...list].sort((a, b) => hotScore(b, now) - hotScore(a, now))

  if (categorySlug || tab === "recentes") return list.sort((a, b) => Number(b.pinned) - Number(a.pinned))
  return list.filter((item) => !item.pinned || !viewer)
}

const STOP_WORDS = new Set(
  "pour dans avec comment quel quelle quels quelles faut vous nous mon mes une des les sur que qui plus faire avez bien encore entre leur votre vos mais pas sont cette ces être avoir tout après avant est".split(
    " "
  )
)

export type SimilarCandidate = { id: string; title: string; repliesCount: number; solved: boolean }

export function findSimilar<T extends SimilarCandidate>(known: T[], query: string): T[] {
  const words = (query.toLowerCase().match(/[a-zà-ÿ0-9-]{3,}/g) ?? []).filter((word) => !STOP_WORDS.has(word))
  if (!words.length) return []
  return known
    .map((entry) => ({ entry, score: words.filter((word) => entry.title.toLowerCase().includes(word)).length }))
    .filter(({ score }) => score)
    .sort((a, b) => b.score - a.score)
    .slice(0, 3)
    .map(({ entry }) => entry)
}
