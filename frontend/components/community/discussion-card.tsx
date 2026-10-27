import { Check, Eye, ThumbsUp } from "lucide-react"
import Link from "next/link"

import { formatRelativeTime } from "@/lib/format/relative-time"
import { cn } from "@/lib/utils"
import { totalVotes, type Discussion } from "@/modules/discussions/domain/discussion"
import { DiscussionTags } from "./discussion-tags"
import { NotePin } from "./notes"
import { RoleTags } from "./role-tags"
import { AvatarStack, UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"

const plain = (text: string) => text.replace(/\*\*/g, "").replace(/\n+/g, " ")

function CountBox({ discussion }: { discussion: Discussion }) {
  const count = discussion.repliesCount
  const label = `réponse${count > 1 ? "s" : ""}`
  if (discussion.type === "poll")
    return (
      <div className="flex h-[58px] w-[62px] flex-col items-center justify-center rounded-[9px] border border-transparent bg-fill leading-[1.1] text-ink-2">
        <b className="text-[19px] font-semibold text-foreground tabular-nums">
          {totalVotes(discussion).toLocaleString("fr-FR")}
        </b>
        <span className="text-[10.5px] tracking-[.02em]">votes</span>
      </div>
    )
  if (discussion.solutionId)
    return (
      <div className="flex h-[58px] w-[62px] flex-col items-center justify-center rounded-[9px] border border-ok bg-ok leading-[1.1] text-card">
        <b className="flex items-center gap-0.5 text-[19px] font-semibold text-card tabular-nums">
          <Check className="size-3.5" />
          {count}
        </b>
        <span className="text-[10.5px] tracking-[.02em]">{label}</span>
      </div>
    )
  return (
    <div
      className={cn(
        "flex h-[58px] w-[62px] flex-col items-center justify-center rounded-[9px] border border-line leading-[1.1] text-ink-2",
        count === 0 && "border-dashed text-destructive"
      )}
    >
      <b className={cn("text-[19px] font-semibold tabular-nums", count === 0 ? "text-destructive" : "text-foreground")}>
        {count}
      </b>
      <span className="text-[10.5px] tracking-[.02em]">{label}</span>
    </div>
  )
}

export function DiscussionCard({
  discussion,
  staff,
  withNote = false,
}: {
  discussion: Discussion
  staff: boolean
  withNote?: boolean
}) {
  const { author, category } = discussion
  return (
    <article
      className={cn(
        "group/card relative grid grid-cols-[62px_minmax(0,1fr)] gap-4 border-t border-line px-[18px] py-4 transition-colors first:border-t-0 hover:bg-[color-mix(in_srgb,var(--surface-2)_70%,var(--card))] max-[760px]:grid-cols-[minmax(0,1fr)] max-[760px]:gap-2 max-[760px]:px-4 max-[760px]:py-3.5",
        discussion.pinned && "bg-surface-3"
      )}
    >
      <div className="max-[760px]:hidden">
        <CountBox discussion={discussion} />
      </div>
      <div className="min-w-0">
        <div className="mb-[5px] flex flex-wrap items-center gap-2 text-[12.5px]">
          <Link
            href={`/espaces/${category.slug}`}
            className="relative z-10 inline-flex items-center gap-1.5 text-[12.5px] font-semibold text-brand-text hover:text-foreground"
          >
            {category.name}
          </Link>
          <DiscussionTags discussion={discussion} staff={staff} />
          {withNote ? <NotePin k="card" /> : null}
        </div>
        <h3 className="font-display text-[18.5px] leading-[1.3] font-bold tracking-[-.01em] text-foreground group-hover/card:text-brand-text">
          <Link
            href={`/discussions/${discussion.id}`}
            className="outline-none after:absolute after:inset-0 focus-visible:after:ring-3 focus-visible:after:ring-brand/45"
          >
            {discussion.title}
          </Link>
        </h3>
        <p className="mt-1 line-clamp-2 text-sm text-ink-2">{plain(discussion.content)}</p>
        <div className="mt-2.5 flex flex-wrap items-center gap-2.5 text-[13px] text-ink-3">
          <span className="inline-flex items-center gap-[7px]">
            <UserAvatar user={author} size="xs" link />
            <UserLink user={author} className="relative z-10 font-semibold text-ink-2">
              {author.name}
            </UserLink>
            {author.role === "redaction" ? <RoleTags user={author} /> : null}
            <span>· {formatRelativeTime(discussion.createdAt)}</span>
          </span>
          <span className="ml-auto inline-flex items-center gap-3.5">
            {discussion.participants.length ? (
              <span className="max-[760px]:hidden">
                <AvatarStack users={discussion.participants} />
              </span>
            ) : null}
            <span className="inline-flex items-center gap-1" title="Utile">
              <ThumbsUp className="size-[15px]" />
              <span className="tabular-nums">{discussion.likes}</span>
            </span>
            <span className="inline-flex items-center gap-1 max-[760px]:hidden" title="Vues">
              <Eye className="size-[15px]" />
              <span className="tabular-nums">{discussion.views.toLocaleString("fr-FR")}</span>
            </span>
          </span>
        </div>
      </div>
    </article>
  )
}
