import { ChevronRight, PenLine } from "lucide-react"
import type { Metadata } from "next"
import Link from "next/link"
import { notFound } from "next/navigation"

import { CommentCard } from "@/components/community/comment-card"
import { CopyLinkButton } from "@/components/community/copy-link-button"
import { BlogCover } from "@/components/community/cover"
import { ReportButton, UsefulButton } from "@/components/community/discussion-actions"
import { PageLayout } from "@/components/community/page-layout"
import { ReplyForm } from "@/components/community/reply-form"
import { ReplyLogin } from "@/components/community/reply-login"
import { RichText } from "@/components/community/rich-text"
import { RoleTags } from "@/components/community/role-tags"
import { SeoPill } from "@/components/community/seo-pill"
import { SiteNewsCard } from "@/components/community/site-news-card"
import { UserAvatar } from "@/components/community/user-avatar"
import { UserLink } from "@/components/community/user-link"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb"
import { formatRelativeTime } from "@/lib/format/relative-time"
import { commentBlogAction } from "@/modules/blogs/presentation/blog.actions"
import { readTime } from "@/modules/blogs/domain/blog"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"
import { blogSeo } from "@/modules/discussions/domain/seo"
import { levelOf } from "@/modules/users/domain/user"

type BlogProps = { params: Promise<{ id: string }> }

export async function generateMetadata({ params }: BlogProps): Promise<Metadata> {
  const post = await community().blogs.findById((await params).id)
  return { title: post?.title ?? "Billet introuvable" }
}

const capitalize = (text: string) => text.charAt(0).toUpperCase() + text.slice(1)

export default async function BlogPostPage({ params }: BlogProps) {
  const { id } = await params
  const deps = community()
  const [viewer, flags, members] = await Promise.all([getSessionUser(), getViewFlags(), deps.users.list()])
  const post = await deps.blogs.findById(id)
  if (!post) notFound()
  const { author, category } = post
  const others = (await deps.blogs.listByAuthor(author.username)).filter((entry) => entry.id !== post.id)
  const users = Object.fromEntries(members.map((member) => [member.username, member]))
  const count = post.commentsCount
  const seo = blogSeo(post.likes)
  const participants = [...new Set([author.username, ...post.comments.map((comment) => comment.author.username)])]

  return (
    <PageLayout
      right={
        <>
          <Card>
            <CardContent>
              <div className="mb-2.5 flex items-center gap-3">
                <UserAvatar user={author} size="lg" link />
                <div>
                  <b className="block text-[15px] font-semibold">{author.name}</b>
                  <small className="text-[12.5px] text-ink-3">
                    {author.role === "member" ? (
                      <>
                        {levelOf(author.points).name} · <span className="tabular-nums">{author.points}</span> points
                      </>
                    ) : (
                      "Compte officiel"
                    )}
                  </small>
                </div>
              </div>
              {author.bio ? <p className="mb-3 text-sm text-ink-2">{author.bio}</p> : null}
              <Button variant="secondary" size="sm" className="w-full" nativeButton={false} render={<Link href={`/membres/${author.username}`} />}>
                Voir le profil
              </Button>
            </CardContent>
          </Card>
          {others.length ? (
            <Card>
              <CardContent>
                <h2 className="mb-3 flex items-center gap-2 text-[13px] font-semibold [&>svg]:size-[18px] [&>svg]:text-brand-text">
                  <PenLine />
                  Du même auteur
                </h2>
                <div className="flex flex-col">
                  {others.map((entry, index) => (
                    <Link
                      key={entry.id}
                      href={`/billets/${entry.id}`}
                      className={`group/post grid grid-cols-[44px_minmax(0,1fr)] items-center gap-2.5 py-3 ${index === 0 ? "pt-0" : "border-t border-line"}`}
                    >
                      <BlogCover category={entry.category} kind="thumb" />
                      <div>
                        <b className="text-[14.5px] font-semibold group-hover/post:text-brand-text">{entry.title}</b>
                        <p className="mt-[3px] text-[13.5px] text-ink-2">{readTime(entry.content)} min de lecture</p>
                      </div>
                    </Link>
                  ))}
                </div>
              </CardContent>
            </Card>
          ) : null}
          <SiteNewsCard />
        </>
      }
    >
      <Breadcrumb aria-label="Fil d'Ariane">
        <BreadcrumbList className="gap-1.5 text-[13.5px] text-ink-3">
          <BreadcrumbItem>
            <BreadcrumbLink render={<Link href={`/membres/${author.username}`} />}>{author.name}</BreadcrumbLink>
          </BreadcrumbItem>
          <BreadcrumbSeparator>
            <ChevronRight className="size-3.5" />
          </BreadcrumbSeparator>
          <BreadcrumbItem>
            <span>Billets</span>
          </BreadcrumbItem>
        </BreadcrumbList>
      </Breadcrumb>

      <Card className="scroll-mt-[90px] px-[22px] py-5 max-[760px]:p-4">
        <article>
          <BlogCover category={category} kind="hero" />
          <div className="mb-[5px] flex flex-wrap items-center gap-2 text-[12.5px]">
            <Badge variant="blog">
              <PenLine />
              Billet de blog
            </Badge>
            {category ? (
              <Link href={`/espaces/${category.slug}`} className="text-[12.5px] font-semibold text-brand-text hover:text-foreground">
                {category.name}
              </Link>
            ) : null}
            <SeoPill staff={flags.staff} feminine={false} indexed={seo.on} reason={seo.reason} />
          </div>
          <h1 className="mt-1.5 mb-3.5 font-display text-[29px] leading-[1.2] font-bold tracking-[-.01em] max-[760px]:text-2xl">
            {post.title}
          </h1>
          <div className="flex items-center gap-[11px]">
            <UserAvatar user={author} size="md" link />
            <div>
              <div className="flex flex-wrap items-center gap-[7px] font-semibold">
                <UserLink user={author}>{author.name}</UserLink> <RoleTags user={author} />
              </div>
              <div className="text-[12.5px] text-ink-3">
                {capitalize(formatRelativeTime(post.createdAt))} · {readTime(post.content)} min de lecture ·{" "}
                <span className="tabular-nums">{post.views.toLocaleString("fr-FR")}</span> lectures
              </div>
            </div>
          </div>
          <div className="mt-3.5 max-w-[68ch] text-[16.5px] leading-[1.7] [overflow-wrap:anywhere]">
            <RichText text={post.content} users={users} />
          </div>
          <div className="mt-4 flex flex-wrap items-center gap-1">
            <UsefulButton subject={{ kind: "blog", id: post.id }} likes={post.likes} liked={post.liked} />
            <CopyLinkButton />
            <ReportButton />
          </div>
        </article>
      </Card>

      <section aria-label="Commentaires" className="flex flex-col gap-3">
        <h2 className="font-display text-[21px] font-bold tracking-[-.01em]">
          {count ? `${count} commentaire${count > 1 ? "s" : ""}` : "Aucun commentaire pour l'instant"}
        </h2>
        {post.comments.map((comment) => (
          <CommentCard key={comment.id} comment={comment} blogId={post.id} viewer={viewer} users={users} />
        ))}
        {viewer ? (
          <ReplyForm
            action={commentBlogAction.bind(null, post.id)}
            draftKey={`comment:${post.id}`}
            author={viewer}
            verb="Commenter"
            submitLabel="Publier mon commentaire"
            participants={participants}
            placeholder={`Réagissez au billet de ${author.name}…`}
          />
        ) : (
          <ReplyLogin
            title="Ce billet vous a parlé ?"
            text="Rejoignez la communauté avec votre compte lerevenu.com pour le commenter."
            action="Se connecter pour commenter"
          />
        )}
      </section>
    </PageLayout>
  )
}
