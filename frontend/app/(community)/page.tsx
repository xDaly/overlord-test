import { redirect } from "next/navigation"

import { CatScroller } from "@/components/community/cat-scroller"
import { HomeRight } from "@/components/community/columns"
import { DiscussionFeed } from "@/components/community/discussion-feed"
import { FeedPager, FeedSort } from "@/components/community/feed-pager"
import { Greeting } from "@/components/community/greeting"
import { Hero } from "@/components/community/hero"
import { PageLayout } from "@/components/community/page-layout"
import { QuickComposer } from "@/components/community/quick-composer"
import { listCategories } from "@/modules/categories/categories.container"
import { getCommunityStats } from "@/modules/community/application/community-stats"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"
import { listDiscussions } from "@/modules/discussions/application/list-discussions.use-case"
import { availableTabs, resolveFeedTab } from "@/modules/discussions/presentation/feed-tab"
import { FEED_PAGE_SIZE, outOfRangeHref, resolveOrder, resolvePage } from "@/modules/discussions/presentation/feed-paging"

type HomeProps = { searchParams: Promise<{ tri?: string; page?: string; ordre?: string }> }

export default async function HomePage({ searchParams }: HomeProps) {
  const { tri, page: pageParam, ordre } = await searchParams
  const order = resolveOrder(ordre)
  const deps = community()
  const [user, flags] = await Promise.all([getSessionUser(), getViewFlags()])
  const context = { logged: Boolean(user), inCategory: false }
  const tab = resolveFeedTab(tri, context)
  const [feed, unanswered, featuredPoll, categories] = await Promise.all([
    listDiscussions(deps, { tab, viewer: user, order, page: resolvePage(pageParam), pageSize: FEED_PAGE_SIZE }),
    deps.discussions.countUnanswered(),
    deps.discussions.featured("poll", user?.username),
    listCategories(),
  ])
  const pastTheEnd = outOfRangeHref("/", { tri, ordre }, feed)
  if (pastTheEnd) redirect(pastTheEnd)
  const stats = user ? null : await getCommunityStats(deps, categories)

  return (
    <PageLayout active="home" right={<HomeRight user={user} />}>
      {user ? <Greeting user={user} /> : stats ? <Hero stats={stats} /> : null}
      <QuickComposer />
      <CatScroller categories={categories} />
      <FeedSort basePath="/" params={{ tri, ordre }} order={order} />
      <DiscussionFeed
        discussions={feed.items}
        tab={tab}
        tabs={availableTabs(context)}
        fallback={resolveFeedTab(undefined, context)}
        unansweredCount={unanswered}
        staff={flags.staff}
        initialDensity={flags.density}
        inlinePoll={featuredPoll}
      />
      <FeedPager basePath="/" params={{ tri, ordre }} page={feed.page} pageCount={feed.pageCount} total={feed.total} />
    </PageLayout>
  )
}
