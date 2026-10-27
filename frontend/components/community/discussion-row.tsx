import { Check } from "lucide-react"
import Link from "next/link"

import { formatRelativeTime } from "@/lib/format/relative-time"
import { cn } from "@/lib/utils"
import type { Discussion } from "@/modules/discussions/domain/discussion"
import { CategoryIcon } from "./category-icon"
import { DiscussionTags } from "./discussion-tags"

const COLUMNS =
  "grid grid-cols-[minmax(0,1fr)_70px_56px_64px] items-center gap-2.5 px-[18px] max-[760px]:grid-cols-[minmax(0,1fr)_62px_52px] max-[760px]:px-3.5"

const NUMBER = "text-right text-[13.5px] whitespace-nowrap text-ink-2 tabular-nums"

function shortAge(iso: string): string {
  const minutes = (Date.now() - new Date(iso).getTime()) / 60_000
  if (minutes < 60) return `${Math.max(1, Math.round(minutes))} min`
  const hours = Math.round(minutes / 60)
  return hours < 24 ? `${hours} h` : `${Math.round(hours / 24)} j`
}

function shortCount(value: number) {
  return value >= 1000 ? `${(value / 1000).toFixed(1).replace(".", ",").replace(",0", "")} k` : String(value)
}

export function DiscussionRowHead() {
  return (
    <div className={cn(COLUMNS, "bg-surface-2 py-2 text-[11.5px] font-semibold text-ink-3")}>
      <span>Discussion</span>
      <span className="text-right">Réponses</span>
      <span className="text-right max-[760px]:hidden">Vues</span>
      <span className="text-right">Activité</span>
    </div>
  )
}

export function DiscussionRow({ discussion, staff }: { discussion: Discussion; staff: boolean }) {
  const { category, repliesCount } = discussion
  return (
    <div
      className={cn(
        COLUMNS,
        "group/row relative border-t border-line py-[9px] transition-colors first:border-t-0 hover:bg-[color-mix(in_srgb,var(--surface-2)_70%,var(--card))] max-[760px]:py-2.5",
        discussion.pinned && "bg-surface-3"
      )}
    >
      <span className="flex min-w-0 items-center gap-2.5">
        <CategoryIcon category={category} className="size-7 rounded-[8px] [&_svg]:size-4" />
        <span className="flex min-w-0 flex-col">
          <b className="truncate text-[14.5px] font-semibold text-foreground group-hover/row:text-brand-text max-[760px]:line-clamp-2 max-[760px]:whitespace-normal">
            <Link href={`/discussions/${discussion.id}`} className="outline-none after:absolute after:inset-0">
              {discussion.title}
            </Link>
          </b>
          <span className="flex min-w-0 items-center gap-1.5 [&_svg]:size-[11px] [&>span]:px-1.5 [&>span]:text-[10.5px] max-[760px]:[&>span:not(:last-child)]:hidden">
            <small className="min-w-0 truncate text-xs text-ink-3">
              {category.name} · {discussion.author.name}
            </small>
            <DiscussionTags discussion={discussion} staff={staff} />
          </span>
        </span>
      </span>
      <span className={NUMBER}>
        {discussion.solutionId ? (
          <span className="inline-flex items-center gap-0.5 font-semibold text-ok">
            <Check className="size-3.5" />
            {repliesCount}
          </span>
        ) : (
          <span className={cn(repliesCount === 0 && "font-semibold text-destructive")}>{repliesCount}</span>
        )}
      </span>
      <span className={cn(NUMBER, "max-[760px]:hidden")}>{shortCount(discussion.views)}</span>
      <span className={NUMBER} title={`Dernière activité ${formatRelativeTime(discussion.lastActivityAt)}`}>
        {shortAge(discussion.lastActivityAt)}
      </span>
    </div>
  )
}
