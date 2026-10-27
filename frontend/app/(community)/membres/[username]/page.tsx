import { BadgeCheck, Check, Flame } from "lucide-react"
import type { Metadata } from "next"
import Link from "next/link"
import { notFound } from "next/navigation"
import type { ReactNode } from "react"

import { BadgeIcon } from "@/components/community/badge-icon"
import { BlogCard } from "@/components/community/blog-card"
import { DiscussionCard } from "@/components/community/discussion-card"
import { NotePin } from "@/components/community/notes"
import { PageLayout } from "@/components/community/page-layout"
import { EmptyAction, PhotoEditButton, ProfileActions } from "@/components/community/profile-parts"
import { QueryTabs, type QueryTab } from "@/components/community/query-tabs"
import { RoleTags } from "@/components/community/role-tags"
import { UserAvatar } from "@/components/community/user-avatar"
import { Badge } from "@/components/ui/badge"
import { Card, CardContent } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { cn } from "@/lib/utils"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"
import { BADGES, BADGE_CODES } from "@/modules/users/domain/badges"
import { LEVELS, levelOf } from "@/modules/users/domain/user"

type Tab = "billets" | "discussions" | "reponses" | "progression"

type ProfileProps = {
  params: Promise<{ username: string }>
  searchParams: Promise<{ onglet?: string }>
}

export async function generateMetadata({ params }: Pick<ProfileProps, "params">): Promise<Metadata> {
  const member = await community().users.findByUsername((await params).username)
  return { title: member?.name ?? "Membre introuvable" }
}

function Empty({ title, text, action }: { title: string; text: string; action?: ReactNode }) {
  return (
    <Card className="px-5 py-10 text-center text-ink-2">
      <h3 className="mb-1.5 font-display text-xl font-bold tracking-[-.01em] text-foreground">{title}</h3>
      <p>{text}</p>
      {action}
    </Card>
  )
}

const FEED = "flex flex-col overflow-hidden rounded-lg border border-hairline bg-card shadow-card"

export default async function ProfilePage({ params, searchParams }: ProfileProps) {
  const [{ username }, { onglet }] = await Promise.all([params, searchParams])
  const deps = community()
  const [viewer, flags, member] = await Promise.all([getSessionUser(), getViewFlags(), deps.users.findByUsername(username)])
  if (!member) notFound()

  const [blogs, topics, replies] = await Promise.all([
    deps.blogs.listByAuthor(username),
    deps.discussions.listByAuthor(username, viewer?.username),
    deps.discussions.listRepliesBy(username),
  ])
  const isMe = viewer?.username === username
  const isMember = member.role === "member"
  const level = levelOf(member.points)

  const tabs: QueryTab[] = [
    { value: "billets", label: "Billets", icon: "pen", count: blogs.length, countTone: "muted" },
    { value: "discussions", label: "Discussions", icon: "message" },
    { value: "reponses", label: "Réponses", icon: "reply" },
    ...(isMember ? [{ value: "progression", label: "Progression", icon: "trophy" } satisfies QueryTab] : []),
  ]
  const fallback: Tab = blogs.length || isMe ? "billets" : "discussions"
  const active = (tabs.find((tab) => tab.value === onglet)?.value ?? fallback) as Tab

  const stats: [string, string | number, boolean?][] = [
    ["points", member.points, true],
    ["billets", blogs.length],
    ["discussions", member.stats.topics],
    ["réponses", member.stats.replies],
    ["« Utile » reçus", member.stats.likes],
    ["meilleures réponses", member.stats.solutions],
  ]

  let body: ReactNode
  if (active === "billets")
    body = blogs.length ? (
      <div className={FEED}>
        {blogs.map((post) => (
          <BlogCard key={post.id} post={post} staff={flags.staff} withAuthor={false} />
        ))}
      </div>
    ) : isMe ? (
      <Empty
        title="Votre premier billet"
        text="Un placement, une erreur, une méthode : racontez votre expérience, elle aidera d'autres lecteurs."
        action={<EmptyAction kind="blog" />}
      />
    ) : (
      <Empty title="Aucun billet pour l'instant" text={`${member.name} n'a pas encore publié de billet.`} />
    )
  else if (active === "discussions")
    body = topics.length ? (
      <div className={FEED}>
        {topics.map((topic) => (
          <DiscussionCard key={topic.id} discussion={topic} staff={flags.staff} />
        ))}
      </div>
    ) : (
      <Empty
        title="Aucune discussion"
        text={isMe ? "Posez votre première question à la communauté." : `${member.name} n'a pas encore lancé de discussion.`}
        action={isMe ? <EmptyAction kind="discussion" /> : undefined}
      />
    )
  else if (active === "reponses")
    body = replies.length ? (
      <Card>
        <CardContent>
          <div className="flex flex-col">
            {replies.slice(0, 8).map((reply, index) => (
              <Link
                key={`${reply.discussionId}-${index}`}
                href={`/discussions/${reply.discussionId}`}
                className={cn("group/reply block py-3", index === 0 ? "pt-0" : "border-t border-line")}
              >
                <b className="text-[14.5px] font-semibold group-hover/reply:text-brand-text">{reply.discussionTitle}</b>
                {reply.isSolution ? (
                  <Badge variant="solved" className="ml-1.5">
                    <Check />
                    Meilleure réponse
                  </Badge>
                ) : null}
                <p className="mt-[3px] text-[13.5px] text-ink-2">
                  {reply.content.slice(0, 160)}
                  {reply.content.length > 160 ? "…" : ""}
                </p>
              </Link>
            ))}
          </div>
        </CardContent>
      </Card>
    ) : (
      <Empty
        title="Aucune réponse"
        text={isMe ? "Aidez un membre : les questions sans réponse vous attendent." : `${member.name} n'a pas encore répondu à une discussion.`}
      />
    )
  else
    body = (
      <>
        <Card>
          <CardContent>
            <h2 className="mb-3 flex items-center gap-2 text-[13px] font-semibold">
              Niveau <NotePin k="progress" />
            </h2>
            <div className="mb-2.5">
              <h3 className="font-display text-xl font-bold">{level.name}</h3>
              <small className="text-[13px] text-ink-3">
                {level.next ? (
                  <>
                    Encore <b className="tabular-nums">{level.next - member.points}</b> points pour devenir « {level.nextName} »
                  </>
                ) : (
                  "Niveau maximum atteint"
                )}
              </small>
            </div>
            <Progress value={level.progress} aria-label="Progression vers le niveau suivant" />
            <div className="mt-3.5 flex gap-1.5">
              {LEVELS.map(([min, name], index) => (
                <div
                  key={name}
                  className={cn(
                    "flex-1 border-t-4 border-fill-2 pt-2 text-center text-[11.5px] leading-[1.3] text-ink-3",
                    index < level.index && "border-brand-text text-ink-2",
                    index === level.index && "border-brand-text font-semibold text-foreground"
                  )}
                >
                  {name}
                  <br />
                  <span className="tabular-nums">{min}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
        <Card>
          <CardContent>
            <h2 className="mb-3 flex items-center gap-2 text-[13px] font-semibold">
              Badges{" "}
              <span className="tabular-nums">
                {member.badges.length}/{BADGE_CODES.length}
              </span>{" "}
              <NotePin k="rewards" />
            </h2>
            <div className="grid grid-cols-[repeat(auto-fill,minmax(150px,1fr))] gap-2.5">
              {BADGE_CODES.map((code) => {
                const owned = member.badges.includes(code)
                return (
                  <div
                    key={code}
                    className="flex flex-col items-center gap-1.5 rounded-xl border border-hairline bg-card px-2.5 py-3.5 text-center"
                  >
                    <BadgeIcon code={code} size="lg" locked={!owned} />
                    <b className={cn("text-sm font-semibold", !owned && "text-ink-3")}>{BADGES[code].name}</b>
                    <small className="text-xs leading-[1.35] text-ink-3">{BADGES[code].description}</small>
                  </div>
                )
              })}
            </div>
          </CardContent>
        </Card>
      </>
    )

  return (
    <PageLayout>
      <Card className="flex-row flex-wrap items-center gap-5">
        <CardContent className="flex w-full flex-wrap items-center gap-5">
          <div className="relative shrink-0">
            <UserAvatar user={member} size="xl" />
            {isMe ? <PhotoEditButton /> : null}
          </div>
          <div className="min-w-[220px] flex-1">
            <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">
              {member.name} {isMe ? <NotePin k="photo" /> : null}
            </h1>
            <div className="mt-1 flex flex-wrap items-center gap-2 text-[13.5px] text-ink-3">
              @{member.username} <RoleTags user={member} />
              {isMember ? (
                <>
                  {" · "}
                  <Flame className="size-[18px]" /> {member.streak ?? 3} jours d&apos;affilée
                </>
              ) : null}
            </div>
            {member.expertTitle ? (
              <p className="mt-2 inline-flex items-center gap-1.5 text-[13.5px] font-semibold text-pro">
                <BadgeCheck className="size-4" />
                {member.expertTitle} · expertise vérifiée par l&apos;équipe du Revenu
              </p>
            ) : null}
            {member.bio ? (
              <p className="mt-2.5 max-w-[60ch] text-ink-2">{member.bio}</p>
            ) : isMe ? (
              <p className="mt-2.5 max-w-[60ch] text-ink-3">
                Ajoutez une courte présentation pour que les membres vous connaissent.
              </p>
            ) : null}
          </div>
          {isMe ? <ProfileActions /> : null}
        </CardContent>
      </Card>
      {isMember ? (
        <div className="grid grid-cols-6 gap-2.5 max-[760px]:grid-cols-3">
          {stats.map(([label, value, score]) => (
            <div
              key={label}
              className="rounded-lg border border-hairline bg-card p-3.5 text-center shadow-card"
            >
              <b className={cn("block text-[22px] font-semibold tabular-nums", score && "text-brand-text")}>{value}</b>
              <small className="text-[12.5px] text-ink-3">{label}</small>
            </div>
          ))}
        </div>
      ) : null}
      <div className="flex items-center gap-1">
        <QueryTabs param="onglet" active={active} fallback={fallback} tabs={tabs} />
        <NotePin k="blog" />
      </div>
      {body}
    </PageLayout>
  )
}
