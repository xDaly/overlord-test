import { Card } from "@/components/ui/card"
import { formatRelativeTime } from "@/lib/format/relative-time"
import { cn } from "@/lib/utils"
import type { BlogComment } from "@/modules/blogs/domain/blog"
import type { User } from "@/modules/users/domain/user"
import { ReplyToButton, ReportButton, UsefulButton } from "./discussion-actions"
import { RichText } from "./rich-text"
import { RoleTags } from "./role-tags"
import { UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"

export function CommentCard({
  comment,
  blogId,
  viewer,
  users,
}: {
  comment: BlogComment
  blogId: string
  viewer: User | null
  users: Record<string, User>
}) {
  const { author } = comment
  return (
    <Card
      id={`r${comment.id}`}
      data-reply
      className={cn(
        "scroll-mt-[90px] px-5 py-4 max-[760px]:p-4",
        author.role === "redaction" && "border-redac/35 bg-redac-soft"
      )}
    >
      <article>
        <div className="flex items-center gap-[11px]">
          <UserAvatar user={author} size="sm" link />
          <div>
            <div className="flex flex-wrap items-center gap-[7px] font-semibold">
              <UserLink user={author}>{author.name}</UserLink> <RoleTags user={author} />
            </div>
            <div className="text-[12.5px] text-ink-3">{formatRelativeTime(comment.createdAt)}</div>
          </div>
        </div>
        <div className="mt-2.5 max-w-[68ch] text-[15px] leading-[1.65] [overflow-wrap:anywhere]">
          <RichText text={comment.content} users={users} />
        </div>
        <div className="mt-4 flex flex-wrap items-center gap-1">
          <UsefulButton
            subject={{ kind: "blog", id: blogId, replyId: comment.id }}
            likes={comment.likes}
            liked={comment.liked}
          />
          {viewer?.username === author.username ? null : <ReplyToButton username={author.username} />}
          <ReportButton label={false} />
        </div>
      </article>
    </Card>
  )
}
