import { Check, ExternalLink, Globe, X } from "lucide-react"
import Link from "next/link"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { formatRelativeTime } from "@/lib/format/relative-time"
import { cn } from "@/lib/utils"
import type { Category } from "@/modules/categories/domain/category"
import type { DiscussionDetail } from "@/modules/discussions/domain/discussion"
import { seoStatus } from "@/modules/discussions/domain/seo"
import { CategoryIcon } from "./category-icon"
import { NotePin } from "./notes"
import { PublishButton } from "./publish-button"
import { SeoPill } from "./seo-pill"
import { SiteLink } from "./site-link"
import { UserAvatar } from "./user-avatar"

const CARD_TITLE = "mb-3 flex items-center gap-2 text-[13px] font-semibold [&>svg]:size-[18px] [&>svg]:text-brand-text"

const participantsOf = (discussion: DiscussionDetail) => [
  ...new Map(
    [discussion.author, ...discussion.replies.map((reply) => reply.author)].map((user) => [user.username, user])
  ).values(),
]

export function HelpCard({ discussion }: { discussion: DiscussionDetail }) {
  return (
    <Card className="border-transparent bg-surface-3">
      <CardContent>
        <h3 className="mb-1 text-[15.5px] font-semibold">Soyez le premier à aider {discussion.author.name}</h3>
        <p className="mb-3 text-[13.5px] text-ink-2">
          Une question sans réponse depuis {formatRelativeTime(discussion.createdAt).replace("il y a ", "")}. Votre
          expérience compte, même partielle.
        </p>
        <Button size="sm" nativeButton={false} render={<Link href="#repondre" />}>
          Répondre (+3 points)
        </Button>
      </CardContent>
    </Card>
  )
}

export function SeoCard({ discussion }: { discussion: DiscussionDetail }) {
  const status = seoStatus(discussion.seo)
  return (
    <Card>
      <CardContent>
        <h2 className={CARD_TITLE}>
          <Globe />
          Référencement <NotePin k="seo" />
          <span className="ml-auto">
            <SeoPill seo={discussion.seo} staff />
          </span>
        </h2>
        <p className="mb-2.5 text-sm font-semibold">{status.reason}</p>
        <ul className="mb-2.5 flex flex-col gap-1.5 text-[13px] text-ink-3">
          {status.checks.map(([label, passed]) => (
            <li key={label} className={cn("flex items-start gap-2", passed && "text-foreground")}>
              {passed ? (
                <Check className="mt-0.5 size-[15px] shrink-0 text-ok" />
              ) : (
                <X className="mt-0.5 size-[15px] shrink-0" />
              )}
              {label}
            </li>
          ))}
        </ul>
        <p className="text-[12.5px] text-ink-3">
          {status.on ? "Page proposée à Google, balisée en QAPage." : "Page lisible par tous, balise noindex."} Visible
          uniquement par la rédaction et la modération.
        </p>
      </CardContent>
    </Card>
  )
}

export function FactsCard({ discussion }: { discussion: DiscussionDetail }) {
  const facts: [string, string][] = [
    ["Réponses", String(discussion.repliesCount)],
    ["Utile", String(discussion.usefulTotal)],
    ["Vues", discussion.views.toLocaleString("fr-FR")],
  ]
  return (
    <Card>
      <CardContent>
        <h2 className="mb-3 text-[13px] font-semibold">Cette discussion</h2>
        <div className="grid grid-cols-2 gap-x-2.5 gap-y-3">
          {facts.map(([label, value]) => (
            <div key={label}>
              <small className="block text-xs text-ink-3">{label}</small>
              <b className="text-base font-semibold tabular-nums">{value}</b>
            </div>
          ))}
          <div>
            <small className="block text-xs text-ink-3">Dernière activité</small>
            <b className="text-[13.5px] font-semibold">{formatRelativeTime(discussion.lastActivityAt)}</b>
          </div>
        </div>
        <div className="mt-3.5">
          <small className="text-xs text-ink-3">Participants</small>
          <div className="mt-1.5 flex">
            {participantsOf(discussion)
              .slice(0, 8)
              .map((user) => (
                <UserAvatar
                  key={user.username}
                  user={user}
                  size="sm"
                  link
                  className="-ml-[7px] ring-2 ring-card first:ml-0"
                />
              ))}
          </div>
        </div>
      </CardContent>
    </Card>
  )
}

export function CategoryCard({ category }: { category: Category }) {
  return (
    <Card>
      <CardContent>
        <h3 className="flex items-center gap-2 font-display text-lg font-bold tracking-[-.01em]">
          <CategoryIcon category={category} />
          {category.name}
        </h3>
        <p className="mt-1.5 mb-3 text-sm text-ink-2">{category.description}</p>
        <PublishButton category={category.slug} variant="secondary" size="sm">
          Publier dans cet espace
        </PublishButton>
        {category.siteSection ? (
          <div>
            <SiteLink className="mt-2.5 inline-flex items-center gap-1.5 text-[13.5px] font-medium text-brand-text hover:underline">
              <ExternalLink className="size-3.5" />
              La rubrique sur lerevenu.com
            </SiteLink>
          </div>
        ) : null}
      </CardContent>
    </Card>
  )
}
