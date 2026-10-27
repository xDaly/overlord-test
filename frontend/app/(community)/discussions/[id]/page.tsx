import { ChevronRight } from "lucide-react"
import type { Metadata } from "next"
import Link from "next/link"
import { notFound } from "next/navigation"

import { CategoryCard, FactsCard, HelpCard, SeoCard } from "@/components/community/discussion-aside"
import { DiscussionCard } from "@/components/community/discussion-card"
import { DiscussionPost } from "@/components/community/discussion-post"
import { NotePin } from "@/components/community/notes"
import { PageLayout } from "@/components/community/page-layout"
import { ReplyCard } from "@/components/community/reply-card"
import { ReplyForm } from "@/components/community/reply-form"
import { ReplyLogin } from "@/components/community/reply-login"
import { SolutionCallout } from "@/components/community/solution-callout"
import { EventsWidget } from "@/components/community/widgets"
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb"
import { AppError } from "@/lib/errors"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"
import { getDiscussion } from "@/modules/discussions/application/get-discussion.use-case"
import { listDiscussions } from "@/modules/discussions/application/list-discussions.use-case"
import { publishReplyAction } from "@/modules/discussions/presentation/discussion.actions"

const RELATED_COUNT = 3

type DiscussionProps = { params: Promise<{ id: string }> }

export async function generateMetadata({ params }: DiscussionProps): Promise<Metadata> {
  const discussion = await community().discussions.findById((await params).id)
  return { title: discussion?.title ?? "Discussion introuvable" }
}

export default async function DiscussionPage({ params }: DiscussionProps) {
  const { id } = await params
  const deps = community()
  const [user, flags, members] = await Promise.all([getSessionUser(), getViewFlags(), deps.users.list()])
  const discussion = await getDiscussion(deps, id, user?.username).catch((error) => {
    if (error instanceof AppError && error.code === "not-found") notFound()
    throw error
  })
  const { category } = discussion
  const [related, events] = await Promise.all([
    listDiscussions(deps, { tab: "tendances", categorySlug: category.slug, viewer: user }),
    deps.events.list({ categorySlug: category.slug }),
  ])
  const relatedItems = related.items.filter((item) => item.id !== discussion.id).slice(0, RELATED_COUNT)
  const users = Object.fromEntries(members.map((member) => [member.username, member]))
  const count = discussion.repliesCount
  const isAuthor = user?.username === discussion.author.username
  const solution = discussion.replies.find((reply) => reply.id === discussion.solutionId)
  const firstRedaction = discussion.replies.find((reply) => reply.author.role === "redaction")
  const participants = [...new Set([discussion.author.username, ...discussion.replies.map((reply) => reply.author.username)])]

  return (
    <PageLayout
      active={{ category: category.slug }}
      right={
        <>
          {count === 0 && !isAuthor ? <HelpCard discussion={discussion} /> : null}
          {flags.staff ? <SeoCard discussion={discussion} /> : null}
          <FactsCard discussion={discussion} />
          <CategoryCard category={category} />
          <EventsWidget events={events} />
        </>
      }
    >
      <Breadcrumb aria-label="Fil d'Ariane">
        <BreadcrumbList className="gap-1.5 text-[13.5px] text-ink-3">
          <BreadcrumbItem>
            <BreadcrumbLink render={<Link href="/" />}>Accueil</BreadcrumbLink>
          </BreadcrumbItem>
          <BreadcrumbSeparator>
            <ChevronRight className="size-3.5" />
          </BreadcrumbSeparator>
          <BreadcrumbItem>
            <BreadcrumbLink render={<Link href={`/espaces/${category.slug}`} />}>{category.name}</BreadcrumbLink>
          </BreadcrumbItem>
        </BreadcrumbList>
      </Breadcrumb>

      <DiscussionPost discussion={discussion} staff={flags.staff} users={users} />
      {solution ? <SolutionCallout reply={solution} /> : null}

      <section aria-label="Réponses" className="flex flex-col gap-3">
        <h2 className="font-display text-[21px] font-bold tracking-[-.01em]">
          {count ? `${count} réponse${count > 1 ? "s" : ""}` : "Aucune réponse pour l'instant"}
        </h2>
        {discussion.replies.map((reply) => (
          <ReplyCard
            key={reply.id}
            reply={reply}
            discussion={discussion}
            viewer={user}
            staff={flags.staff}
            users={users}
            firstFromRedaction={reply.id === firstRedaction?.id}
          />
        ))}
        {user ? (
          <ReplyForm
            action={publishReplyAction.bind(null, discussion.id)}
            draftKey={`reply:${discussion.id}`}
            author={user}
            verb="Répondre"
            submitLabel="Publier ma réponse"
            participants={participants}
            placeholder={
              discussion.type === "question"
                ? `Partagez votre expérience pour aider ${discussion.author.name}…`
                : "Votre avis sur la question…"
            }
          />
        ) : (
          <ReplyLogin
            title="Vous avez un avis ou une expérience à partager ?"
            text="Rejoignez la communauté avec votre compte lerevenu.com."
            action="Se connecter pour répondre"
          />
        )}
      </section>

      {relatedItems.length ? (
        <section className="flex flex-col gap-3">
          <h2 className="font-display text-[21px] font-bold tracking-[-.01em]">
            À lire aussi dans {category.name} <NotePin k="related" />
          </h2>
          <div className="flex flex-col overflow-hidden rounded-lg border border-hairline bg-card shadow-card">
            {relatedItems.map((item) => (
              <DiscussionCard key={item.id} discussion={item} staff={flags.staff} />
            ))}
          </div>
        </section>
      ) : null}
    </PageLayout>
  )
}
