import type { Metadata } from "next"
import Link from "next/link"

import { CategoryIcon } from "@/components/community/category-icon"
import { PageLayout } from "@/components/community/page-layout"
import { listCategories } from "@/modules/categories/categories.container"

export const metadata: Metadata = { title: "Tous les espaces" }

export default async function SpacesPage() {
  const categories = await listCategories()
  return (
    <PageLayout active="spaces">
      <header>
        <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">Tous les espaces</h1>
        <p className="mt-1.5 max-w-[62ch] text-ink-2">
          Des espaces thématiques, calqués sur les grandes rubriques du Revenu.
        </p>
      </header>
      <div className="grid grid-cols-[repeat(auto-fill,minmax(250px,1fr))] gap-3.5">
        {categories.length === 0 ? (
          <p className="text-ink-2">Aucun espace pour le moment.</p>
        ) : null}
        {categories.map((category) => (
          <Link
            key={category.slug}
            href={`/espaces/${category.slug}`}
            className="flex flex-col gap-1.5 rounded-lg border border-hairline bg-card p-[18px] shadow-card transition-[transform,box-shadow] hover:-translate-y-0.5 hover:shadow-pop"
          >
            <CategoryIcon category={category} size="md" className="mb-1.5" />
            <h3 className="font-display text-lg font-bold tracking-[-.01em]">{category.name}</h3>
            <p className="flex-1 text-[13.5px] text-ink-2">{category.description}</p>
            <small className="text-[12.5px] text-ink-3">
              <span className="tabular-nums">{category.topicsCount}</span> discussions ·{" "}
              <span className="tabular-nums">{category.repliesCount.toLocaleString("fr-FR")}</span> réponses
            </small>
          </Link>
        ))}
      </div>
    </PageLayout>
  )
}
