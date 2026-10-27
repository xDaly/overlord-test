import { ExternalLink } from "lucide-react"
import type { Metadata } from "next"
import { notFound, redirect } from "next/navigation"

import { CategoryIcon } from "@/components/community/category-icon"
import { CatScroller } from "@/components/community/cat-scroller"
import { CategoryRight } from "@/components/community/columns"
import { DiscussionFeed } from "@/components/community/discussion-feed"
import { FeedPager, FeedSort } from "@/components/community/feed-pager"
import { PageLayout } from "@/components/community/page-layout"
import { PublishButton } from "@/components/community/publish-button"
import { QuickComposer } from "@/components/community/quick-composer"
import { SiteLink } from "@/components/community/site-link"
import { findCategory, listCategories } from "@/modules/categories/categories.container"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"
import { listDiscussions } from "@/modules/discussions/application/list-discussions.use-case"
import { availableTabs, resolveFeedTab } from "@/modules/discussions/presentation/feed-tab"
import { FEED_PAGE_SIZE, outOfRangeHref, resolveOrder, resolvePage } from "@/modules/discussions/presentation/feed-paging"

type SpaceProps = {
  params: Promise<{ slug: string }>
  searchParams: Promise<{ tri?: string; page?: string; ordre?: string }>
}

export async function generateMetadata({ params }: Pick<SpaceProps, "params">): Promise<Metadata> {
  const category = await findCategory((await params).slug)
  return { title: category?.name ?? "Espace introuvable" }
}

export default async function SpacePage({ params, searchParams }: SpaceProps) {
  const [{ slug }, { tri, page: pageParam, ordre }] = await Promise.all([params, searchParams])
  const order = resolveOrder(ordre)
  const [category, categories] = await Promise.all([findCategory(slug), listCategories()])
  if (!category) notFound()
  const deps = community()
  const [user, flags] = await Promise.all([getSessionUser(), getViewFlags()])
  const context = { logged: Boolean(user), inCategory: true }
  const tab = resolveFeedTab(tri, context)
  const [feed, unanswered] = await Promise.all([
    listDiscussions(deps, { tab, categorySlug: slug, viewer: user, order, page: resolvePage(pageParam), pageSize: FEED_PAGE_SIZE }),
    deps.discussions.countUnanswered(slug),
  ])
  const pastTheEnd = outOfRangeHref(`/espaces/${slug}`, { tri, ordre }, feed)
  if (pastTheEnd) redirect(pastTheEnd)

  return (
    <PageLayout active={{ category: slug }} right={<CategoryRight user={user} slug={slug} />}>
      <section className="flex flex-wrap items-center gap-[18px] rounded-lg border border-hairline bg-card p-[22px] shadow-card">
        <CategoryIcon category={category} size="lg" />
        <div className="min-w-[220px] flex-1">
          <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">{category.name}</h1>
          <p className="mt-1 max-w-[60ch] text-ink-2">{category.description}</p>
          <div className="mt-2 flex flex-wrap gap-3.5 text-[13px] text-ink-3">
            <span>
              <b className="tabular-nums">{category.topicsCount}</b> discussions
            </span>
            <span>
              <b className="tabular-nums">{category.repliesCount.toLocaleString("fr-FR")}</b> réponses
            </span>
          </div>
          {category.siteSection ? (
            <SiteLink className="mt-2.5 inline-flex items-center gap-1.5 text-[13.5px] font-medium text-brand-text hover:underline">
              <ExternalLink className="size-3.5" />
              Toute la rubrique « {category.siteSection} » sur lerevenu.com
            </SiteLink>
          ) : null}
        </div>
        <PublishButton category={slug}>Publier ici</PublishButton>
      </section>
      <QuickComposer category={slug} />
      <CatScroller categories={categories} active={slug} />
      <FeedSort basePath={`/espaces/${slug}`} params={{ tri, ordre }} order={order} />
      <DiscussionFeed
        discussions={feed.items}
        tab={tab}
        tabs={availableTabs(context)}
        fallback={resolveFeedTab(undefined, context)}
        unansweredCount={unanswered}
        category={slug}
        staff={flags.staff}
        initialDensity={flags.density}
      />
      <FeedPager basePath={`/espaces/${slug}`} params={{ tri, ordre }} page={feed.page} pageCount={feed.pageCount} total={feed.total} />
    </PageLayout>
  )
}
