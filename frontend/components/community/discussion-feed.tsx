import type { Discussion } from "@/modules/discussions/domain/discussion"
import type { FeedTab } from "@/modules/discussions/domain/feed"
import { DiscussionCard } from "./discussion-card"
import { DiscussionRow, DiscussionRowHead } from "./discussion-row"
import { EmptyFeed } from "./empty-feed"
import { FeedSection } from "./feed-section"
import { PollWidget } from "./widgets"

const FEED = "flex flex-col overflow-hidden rounded-lg border border-hairline bg-card shadow-card"
const INLINE_POLL_POSITION = 3

export function DiscussionFeed({
  discussions,
  tab,
  tabs,
  fallback,
  unansweredCount,
  category,
  staff,
  initialDensity,
  inlinePoll,
}: {
  discussions: Discussion[]
  tab: FeedTab
  tabs: FeedTab[]
  fallback: FeedTab
  unansweredCount: number
  category?: string
  staff: boolean
  initialDensity: "comfy" | "compact"
  inlinePoll?: Discussion | null
}) {
  const empty = (
    <div className={FEED}>
      <EmptyFeed tab={tab} category={category} />
    </div>
  )
  const cards = discussions.map((discussion, index) => (
    <DiscussionCard key={discussion.id} discussion={discussion} staff={staff} withNote={index === 0} />
  ))
  if (inlinePoll && cards.length > INLINE_POLL_POSITION)
    cards.splice(
      INLINE_POLL_POSITION,
      0,
      <PollWidget
        key="inline-poll"
        discussion={inlinePoll}
        className="hidden rounded-none border-0 border-t border-line bg-surface-2 shadow-none max-[760px]:flex"
      />
    )

  return (
    <FeedSection
      tabs={tabs}
      active={tab}
      fallback={fallback}
      unansweredCount={unansweredCount}
      initialDensity={initialDensity}
      comfortable={discussions.length ? <div className={FEED}>{cards}</div> : empty}
      compact={
        discussions.length ? (
          <div className={FEED}>
            <DiscussionRowHead />
            {discussions.map((discussion) => (
              <DiscussionRow key={discussion.id} discussion={discussion} staff={staff} />
            ))}
          </div>
        ) : (
          empty
        )
      }
    />
  )
}
