import { ExternalLink } from "lucide-react"
import Link from "next/link"

import { Card } from "@/components/ui/card"
import { formatRelativeTime } from "@/lib/format/relative-time"
import type { DiscussionDetail } from "@/modules/discussions/domain/discussion"
import type { User } from "@/modules/users/domain/user"
import { CopyLinkButton } from "./copy-link-button"
import { DiscussionTags } from "./discussion-tags"
import { FollowButton, ReportButton, UsefulButton } from "./discussion-actions"
import { NotePin } from "./notes"
import { PollBox } from "./poll-box"
import { RichText } from "./rich-text"
import { RoleTags } from "./role-tags"
import { SiteLink } from "./site-link"
import { UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"

export function DiscussionPost({
  discussion,
  staff,
  users,
}: {
  discussion: DiscussionDetail
  staff: boolean
  users: Record<string, User>
}) {
  const { author, category } = discussion
  return (
    <Card className="scroll-mt-[90px] px-[22px] py-5 max-[760px]:p-4">
      <article>
        <div className="mb-[5px] flex flex-wrap items-center gap-2 text-[12.5px]">
          <Link
            href={`/espaces/${category.slug}`}
            className="text-[12.5px] font-semibold text-brand-text hover:text-foreground"
          >
            {category.name}
          </Link>
          <DiscussionTags discussion={discussion} staff={staff} />
        </div>
        <h1 className="mt-1.5 mb-3.5 font-display text-[29px] leading-[1.2] font-bold tracking-[-.01em] max-[760px]:text-2xl">
          {discussion.title}
        </h1>
        <div className="flex items-center gap-[11px]">
          <UserAvatar user={author} size="md" link />
          <div>
            <div className="flex flex-wrap items-center gap-[7px] font-semibold">
              <UserLink user={author}>{author.name}</UserLink> <RoleTags user={author} />
            </div>
            <div className="text-[12.5px] text-ink-3">
              {formatRelativeTime(discussion.createdAt)} ·{" "}
              <span className="tabular-nums">{discussion.views.toLocaleString("fr-FR")}</span> vues <NotePin k="pro" />
            </div>
          </div>
        </div>
        <div className="mt-3.5 max-w-[68ch] text-[15.5px] leading-[1.65] [overflow-wrap:anywhere]">
          <RichText text={discussion.content} users={users} />
        </div>
        {discussion.article ? (
          <div className="flex items-center gap-2">
            <SiteLink className="mt-4 flex max-w-[68ch] items-center gap-3.5 rounded-xl border border-hairline bg-surface-2 px-3.5 py-3 hover:border-line-strong hover:bg-card">
              <span className="grid size-[54px] shrink-0 place-items-center rounded-xl bg-brand font-display text-[22px] font-black tracking-[-.01em] text-white shadow-[inset_0_1px_0_rgba(255,255,255,.2)]">
                R
              </span>
              <div>
                <small className="text-xs font-semibold text-ink-3">Article du Revenu</small>
                <b className="block font-display text-base leading-[1.3] tracking-[-.01em]">{discussion.article}</b>
                <span className="mt-1 inline-flex items-center gap-1 text-[12.5px] font-semibold text-brand-text">
                  Lire sur lerevenu.com
                  <ExternalLink className="size-[13px]" />
                </span>
              </div>
            </SiteLink>
            <NotePin k="article" className="mt-4" />
          </div>
        ) : null}
        {discussion.type === "poll" && discussion.options ? (
          <div className="mt-4 max-w-[560px]">
            <PollBox discussionId={discussion.id} options={discussion.options} myVote={discussion.myVote} />
          </div>
        ) : null}
        <div className="mt-4 flex flex-wrap items-center gap-1">
          <UsefulButton
            subject={{ kind: "discussion", id: discussion.id }}
            likes={discussion.likes}
            liked={discussion.liked}
            pin={<NotePin k="useful" />}
          />
          <FollowButton discussionId={discussion.id} followed={discussion.followed} pin={<NotePin k="follow" />} />
          <CopyLinkButton />
          <ReportButton pin={<NotePin k="report" />} />
        </div>
      </article>
    </Card>
  )
}
