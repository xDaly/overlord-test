import type { StrapiClient, StrapiList } from "@/lib/strapi-client"
import { unknownCategory, type Category } from "../domain/category"

export type StrapiCategoryEntry = {
  slug: string
  name: string
  description: string | null
  icon: string | null
  color: string | null
  siteSection: string | null
  discussionsCount?: number
  repliesCount?: number
}

const MAX_CATEGORIES = 100

export function toCategory(entry: StrapiCategoryEntry): Category {
  const fallback = unknownCategory(entry.slug, entry.name)
  return {
    ...fallback,
    description: entry.description ?? "",
    icon: entry.icon || fallback.icon,
    color: entry.color || fallback.color,
    topicsCount: entry.discussionsCount ?? 0,
    repliesCount: entry.repliesCount ?? 0,
    siteSection: entry.siteSection || null,
  }
}

export async function fetchCategories(client: StrapiClient): Promise<Category[]> {
  const result = await client.get<StrapiList<StrapiCategoryEntry>>("/api/categories", {
    fields: ["slug", "name", "description", "icon", "color", "siteSection"],
    sort: ["id:asc"],
    pagination: { pageSize: MAX_CATEGORIES },
  })
  return result.data.map(toCategory)
}
