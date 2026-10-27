import { Calendar, ChartColumn, Flame, PenLine, Star, Trophy } from "lucide-react"
import Link from "next/link"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Progress } from "@/components/ui/progress"
import { cn } from "@/lib/utils"
import { readTime, type BlogPost } from "@/modules/blogs/domain/blog"
import type { CommunityEvent } from "@/modules/events/domain/event"
import type { Discussion } from "@/modules/discussions/domain/discussion"
import { BADGE_CODES } from "@/modules/users/domain/badges"
import { levelOf, type User } from "@/modules/users/domain/user"
import { BadgeIcon } from "./badge-icon"
import { BlogCover } from "./cover"
import { EventRsvpButton } from "./event-rsvp-button"
import { NotePin } from "./notes"
import { PollBox } from "./poll-box"
import { UserAvatar } from "./user-avatar"
import { UserLink } from "./user-link"
import { WriteBlogButton } from "./write-blog-button"

const CARD_TITLE = "mb-3 flex items-center gap-2 text-[13px] font-semibold [&>svg]:size-[18px] [&>svg]:text-brand-text"
const MORE = "ml-auto text-[13px] font-medium text-brand-text hover:underline"
const BADGE_SLOTS = 6

const capitalize = (text: string) => text.charAt(0).toUpperCase() + text.slice(1)

export function ProgressCard({ user }: { user: User }) {
  const level = levelOf(user.points)
  const locked = BADGE_CODES.filter((code) => !user.badges.includes(code)).slice(0, Math.max(0, BADGE_SLOTS - user.badges.length))
  return (
    <Card>
      <CardContent>
        <h2 className={CARD_TITLE}>
          Votre progression <NotePin k="progress" />
          <Link href={`/membres/${user.username}`} className={MORE}>
            Mon profil
          </Link>
        </h2>
        <div className="mb-3.5 flex items-center gap-3">
          <UserAvatar user={user} size="md" />
          <div>
            <h3 className="text-base font-bold">{level.name}</h3>
            <small className="flex items-center gap-1 text-[13px] text-ink-3">
              <span className="tabular-nums">{user.points}</span> points
              {user.streak && user.streak > 1 ? (
                <>
                  {" · "}
                  <Flame className="size-[15px]" /> {user.streak} jours d&apos;affilée
                </>
              ) : null}
            </small>
          </div>
        </div>
        <Progress value={level.progress} aria-label="Progression vers le niveau suivant" />
        <div className="mt-[7px] flex justify-between text-[12.5px] text-ink-3">
          {level.next ? (
            <span>
              Encore <b className="tabular-nums">{level.next - user.points}</b> pts pour « {level.nextName} »
            </span>
          ) : (
            <span>Niveau maximum</span>
          )}
        </div>
        <div className="mt-3.5 flex flex-wrap gap-1.5">
          {user.badges.map((code) => (
            <BadgeIcon key={code} code={code} />
          ))}
          {locked.map((code) => (
            <BadgeIcon key={code} code={code} locked />
          ))}
        </div>
      </CardContent>
    </Card>
  )
}

export function QuestionWidget({ discussion }: { discussion: Discussion }) {
  return (
    <Card>
      <CardContent>
        <div className="mb-2 inline-flex items-center gap-1.5 text-[12.5px] font-semibold text-brand-text [&>svg]:size-[18px]">
          <Star />
          Question de la semaine <NotePin k="weekly" />
        </div>
        <h3 className="font-display text-lg leading-[1.3] font-bold tracking-[-.01em] hover:text-brand-text">
          <Link href={`/discussions/${discussion.id}`}>
            {capitalize(discussion.title.replace(/^Question de la semaine : /, ""))}
          </Link>
        </h3>
        <div className="mt-2 mb-3 flex items-center gap-2 text-[13px] text-ink-3">
          <span className="inline-flex">
            {discussion.participants.slice(0, 4).map((participant) => (
              <UserAvatar
                key={participant.username}
                user={participant}
                size="xs"
                className="-ml-[7px] ring-2 ring-card first:ml-0"
              />
            ))}
          </span>
          <span>
            <span className="tabular-nums">{discussion.repliesCount}</span> réponses · posée par la rédaction
          </span>
        </div>
        <Button variant="secondary" size="sm" nativeButton={false} render={<Link href={`/discussions/${discussion.id}#repondre`} />}>
          Je réponds
        </Button>
      </CardContent>
    </Card>
  )
}

export function PollWidget({ discussion, className }: { discussion: Discussion; className?: string }) {
  return (
    <Card className={className}>
      <CardContent>
        <div className="mb-2 inline-flex items-center gap-1.5 text-[12.5px] font-semibold text-brand-text [&>svg]:size-[18px]">
          <ChartColumn />
          Sondage de la semaine <NotePin k="poll" />
        </div>
        <h3 className="mb-3 font-display text-[17px] leading-[1.3] font-bold hover:text-brand-text">
          <Link href={`/discussions/${discussion.id}`}>
            {capitalize(discussion.title.replace(/^Sondage de la semaine : /, ""))}
          </Link>
        </h3>
        <PollBox discussionId={discussion.id} options={discussion.options ?? []} myVote={discussion.myVote} />
      </CardContent>
    </Card>
  )
}

export function BlogWidget({ posts, canWrite }: { posts: BlogPost[]; canWrite: boolean }) {
  return (
    <Card>
      <CardContent>
        <h2 className={CARD_TITLE}>
          <PenLine />
          Billets des membres <NotePin k="blog" />
        </h2>
        <div className="flex flex-col">
          {posts.map((post, index) => (
            <Link
              key={post.id}
              href={`/billets/${post.id}`}
              className={cn(
                "group/post grid grid-cols-[44px_minmax(0,1fr)] items-center gap-2.5 py-3",
                index > 0 ? "border-t border-line" : "pt-0"
              )}
            >
              <BlogCover category={post.category} kind="thumb" />
              <div>
                <b className="text-[14.5px] font-semibold group-hover/post:text-brand-text">{post.title}</b>
                <p className="mt-[3px] text-[13.5px] text-ink-2">
                  {post.author.name} · {readTime(post.content)} min de lecture
                </p>
              </div>
            </Link>
          ))}
        </div>
        {canWrite ? <WriteBlogButton /> : null}
      </CardContent>
    </Card>
  )
}

const dateParts = (iso: string) => {
  const at = new Date(iso)
  return {
    weekday: at.toLocaleDateString("fr-FR", { weekday: "short" }).replace(".", ""),
    day: at.getDate(),
    month: at.toLocaleDateString("fr-FR", { month: "short" }),
    time: at.toLocaleTimeString("fr-FR", { hour: "2-digit", minute: "2-digit" }),
  }
}

export function EventsWidget({ events }: { events: CommunityEvent[] }) {
  if (!events.length) return null
  return (
    <Card>
      <CardContent>
        <h2 className={CARD_TITLE}>
          <Calendar />
          Le Revenu répond <NotePin k="events" />
        </h2>
        {events.map((event, index) => {
          const when = dateParts(event.at)
          return (
            <div
              key={event.id}
              className={cn("grid grid-cols-[48px_minmax(0,1fr)] gap-3 py-3", index === 0 ? "pt-0" : "border-t border-line")}
            >
              <div className="h-fit overflow-hidden rounded-[10px] border border-hairline bg-card pb-[5px] text-center leading-[1.1] shadow-card">
                <small className="mb-1 block bg-brand py-[3px] text-[10px] font-bold tracking-[.06em] text-white uppercase">
                  {when.weekday}
                </small>
                <b className="text-[19px] tabular-nums">{when.day}</b>
              </div>
              <div>
                <h4 className="text-[14.5px] leading-[1.35] font-semibold">{event.title}</h4>
                <p className="mt-0.5 mb-2 text-[12.5px] text-ink-3">
                  {when.day} {when.month} à {when.time} · {event.host}
                </p>
                <div className="flex flex-wrap items-center gap-2">
                  <EventRsvpButton eventId={event.id} joined={event.joined} />
                  <span className="text-[12.5px] text-ink-3">
                    <span className="tabular-nums">{event.going}</span> participants
                  </span>
                </div>
              </div>
            </div>
          )
        })}
      </CardContent>
    </Card>
  )
}

export function TopWidget({ members }: { members: User[] }) {
  return (
    <Card>
      <CardContent>
        <h2 className={CARD_TITLE}>
          <Trophy />
          Top du mois <NotePin k="top" />
          <Link href="/classement" className={MORE}>
            Classement
          </Link>
        </h2>
        <div>
          {members.map((member, index) => (
            <div key={member.username} className="flex items-center gap-2.5 py-[7px]">
              <span className={cn("w-5 text-center text-[13px] font-semibold text-ink-3 tabular-nums", index < 3 && "text-brand-text")}>
                {index + 1}
              </span>
              <UserAvatar user={member} size="sm" link />
              <UserLink user={member} className="min-w-0 flex-1 truncate text-sm font-semibold">
                {member.name}
                <small className="block text-xs font-normal text-ink-3">{levelOf(member.points).name}</small>
              </UserLink>
              <span className="text-[13px] font-semibold text-brand-text tabular-nums">+{member.month}</span>
            </div>
          ))}
        </div>
      </CardContent>
    </Card>
  )
}
