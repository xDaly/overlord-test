import { cache } from "react"

import { serverStrapiClient } from "@/modules/community/infrastructure/strapi-server-client"
import type { Category } from "./domain/category"
import { fetchCategories } from "./infrastructure/strapi-category.catalog"

export const listCategories = cache((): Promise<Category[]> => fetchCategories(serverStrapiClient()))

export const findCategory = async (slug: string): Promise<Category | undefined> =>
  (await listCategories()).find((category) => category.slug === slug)
