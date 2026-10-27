import { MessageCircle, PenLine, ThumbsUp } from "lucide-react"
import Link from "next/link"

import { Badge } from "@/components/ui/badge"
import { formatRelativeTime } from "@/lib/format/relative-time"
import { blogSeo } from "@/modules/discussions/domain/seo"
import { readTime, type BlogPost } from "@/modules/blogs/domain/blog"
import { BlogCover } from "./cover"
import { SeoPill } from "./seo-pill"
import { UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"

const plain = (text: string) => text.replace(/\*\*/g, "").replace(/\n+/g, " ")

const capitalize = (text: string) => text.charAt(0).toUpperCase() + text.slice(1)

export function BlogCard({ post, staff, withAuthor = true }: { post: BlogPost; staff: boolean; withAuthor?: boolean }) {
  const seo = blogSeo(post.likes)
  return (
    <article className="group/blog relative grid grid-cols-[minmax(0,1fr)_132px] gap-[18px] border-t border-line px-[18px] py-4 transition-colors first:border-t-0 hover:bg-[color-mix(in_srgb,var(--surface-2)_70%,var(--card))] max-[760px]:grid-cols-[minmax(0,1fr)_84px] max-[760px]:gap-3 max-[760px]:px-4 max-[760px]:py-3.5">
      <div className="min-w-0">
        <div className="mb-[5px] flex flex-wrap items-center gap-2 text-[12.5px]">
          <Badge variant="blog">
            <PenLine />
            Billet
          </Badge>
          {post.category ? (
            <Link
              href={`/espaces/${post.category.slug}`}
              className="relative z-10 text-[12.5px] font-semibold text-brand-text hover:text-foreground"
            >
              {post.category.name}
            </Link>
          ) : null}
          <SeoPill staff={staff} feminine={false} indexed={seo.on} reason={seo.reason} />
        </div>
        <h3 className="font-display text-[18.5px] leading-[1.3] font-bold tracking-[-.01em] group-hover/blog:text-brand-text">
          <Link href={`/billets/${post.id}`} className="outline-none after:absolute after:inset-0">
            {post.title}
          </Link>
        </h3>
        <p className="mt-1 line-clamp-2 text-sm text-ink-2">{plain(post.content)}</p>
        <div className="mt-2.5 flex flex-wrap items-center gap-2.5 text-[13px] text-ink-3">
          <span className="inline-flex items-center gap-[7px]">
            {withAuthor ? (
              <>
                <UserAvatar user={post.author} size="xs" link />
                <UserLink user={post.author} className="relative z-10 font-semibold text-ink-2">
                  {post.author.name}
                </UserLink>
                <span>· {formatRelativeTime(post.createdAt)}</span>
              </>
            ) : (
              <span>{capitalize(formatRelativeTime(post.createdAt))}</span>
            )}
            <span>· {readTime(post.content)} min de lecture</span>
          </span>
          <span className="ml-auto inline-flex items-center gap-3.5">
            <span className="inline-flex items-center gap-1" title="Utile">
              <ThumbsUp className="size-[15px]" />
              <span className="tabular-nums">{post.likes}</span>
            </span>
            <span className="inline-flex items-center gap-1" title="Commentaires">
              <MessageCircle className="size-[15px]" />
              <span className="tabular-nums">{post.commentsCount}</span>
            </span>
          </span>
        </div>
      </div>
      <BlogCover category={post.category} kind="card" />
    </article>
  )
}
