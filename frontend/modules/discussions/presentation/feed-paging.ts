import type { DiscussionOrder } from "../domain/discussion"

export const FEED_PAGE_SIZE = 10

export function resolvePage(value: string | undefined): number {
  const page = Number(value)
  return Number.isInteger(page) && page >= 1 ? page : 1
}

export function resolveOrder(value: string | undefined): DiscussionOrder | undefined {
  return value === "anciennes" ? "oldest" : value === "recentes" ? "newest" : undefined
}

export const ORDER_PARAM: Record<DiscussionOrder, string> = { newest: "recentes", oldest: "anciennes" }

type Params = Record<string, string | undefined>

export function outOfRangeHref(
  basePath: string,
  params: Params,
  { page, pageCount }: { page: number; pageCount: number }
): string | null {
  if (pageCount < 1 || page <= pageCount) return null
  return hrefWith(basePath, params, { page: pageCount > 1 ? String(pageCount) : undefined })
}

export function hrefWith(basePath: string, params: Params, changes: Params): string {
  const merged = { ...params, ...changes }
  const search = new URLSearchParams()
  for (const [key, value] of Object.entries(merged)) if (value) search.set(key, value)
  const query = search.toString()
  return query ? `${basePath}?${query}` : basePath
}
