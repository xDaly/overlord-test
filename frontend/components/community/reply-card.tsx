import { BadgeCheck, Check } from "lucide-react"

import { Card } from "@/components/ui/card"
import { formatRelativeTime } from "@/lib/format/relative-time"
import { cn } from "@/lib/utils"
import type { DiscussionDetail, Reply } from "@/modules/discussions/domain/discussion"
import type { User } from "@/modules/users/domain/user"
import { ReplyToButton, ReportButton, SolveButton, UsefulButton, VerifyButton } from "./discussion-actions"
import { NotePin } from "./notes"
import { RichText } from "./rich-text"
import { RoleTags } from "./role-tags"
import { UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"

const FLAG = "mb-2.5 inline-flex items-center gap-[5px] text-[12.5px] font-semibold [&_svg]:size-3.5"

export function ReplyCard({
  reply,
  discussion,
  viewer,
  staff,
  users,
  firstFromRedaction,
}: {
  reply: Reply
  discussion: DiscussionDetail
  viewer: User | null
  staff: boolean
  users: Record<string, User>
  firstFromRedaction: boolean
}) {
  const { author } = reply
  const isSolution = discussion.solutionId === reply.id
  const fromRedaction = author.role === "redaction"
  const mine = viewer?.username === author.username
  const canSolve =
    discussion.type === "question" && viewer && (viewer.username === discussion.author.username || viewer.role === "redaction")

  return (
    <Card
      id={`r${reply.id}`}
      data-reply
      className={cn(
        "scroll-mt-[90px] px-5 py-4 max-[760px]:p-4",
        isSolution && "border-ok shadow-[0_0_0_1px_var(--ok),var(--shadow)]",
        fromRedaction && "border-redac/35 bg-redac-soft"
      )}
    >
      <article>
        {isSolution ? (
          <div className={cn(FLAG, "block text-ok")}>
            <span className="inline-flex items-center gap-[5px]">
              <Check />
              Meilleure réponse
            </span>
          </div>
        ) : null}
        {reply.verified ? (
          <div className={cn(FLAG, "block text-pro")}>
            <span className="inline-flex items-center gap-[5px]">
              <BadgeCheck />
              Vérifiée par la rédaction
            </span>
          </div>
        ) : null}
        {fromRedaction ? (
          <div className={cn(FLAG, "text-redac")}>
            <Check />
            Réponse de la rédaction {firstFromRedaction ? <NotePin k="redaction" /> : null}
          </div>
        ) : null}
        <div className="flex items-center gap-[11px]">
          <UserAvatar user={author} size="sm" link />
          <div>
            <div className="flex flex-wrap items-center gap-[7px] font-semibold">
              <UserLink user={author}>{author.name}</UserLink> <RoleTags user={author} />
            </div>
            <div className="text-[12.5px] text-ink-3">{formatRelativeTime(reply.createdAt)}</div>
          </div>
        </div>
        <div className="mt-2.5 max-w-[68ch] text-[15px] leading-[1.65] [overflow-wrap:anywhere]">
          <RichText text={reply.content} users={users} />
        </div>
        <div className="mt-4 flex flex-wrap items-center gap-1">
          <UsefulButton
            subject={{ kind: "discussion", id: discussion.id, replyId: reply.id }}
            likes={reply.likes}
            liked={reply.liked}
          />
          {mine ? null : <ReplyToButton username={author.username} />}
          {staff && isSolution ? (
            <VerifyButton discussionId={discussion.id} replyId={reply.id} verified={reply.verified} />
          ) : null}
          {canSolve && !mine ? (
            <SolveButton discussionId={discussion.id} replyId={reply.id} chosen={isSolution} />
          ) : null}
          <ReportButton label={false} />
        </div>
      </article>
    </Card>
  )
}
