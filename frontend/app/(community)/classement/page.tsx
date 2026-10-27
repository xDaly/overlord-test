import type { Metadata } from "next"

import { BadgeIcon } from "@/components/community/badge-icon"
import { NotePin } from "@/components/community/notes"
import { PageLayout } from "@/components/community/page-layout"
import { QueryTabs } from "@/components/community/query-tabs"
import { UserAvatar } from "@/components/community/user-avatar"
import { UserLink } from "@/components/community/user-link"
import { Card, CardContent } from "@/components/ui/card"
import { cn } from "@/lib/utils"
import { community } from "@/modules/community/community.container"
import { getSessionUser } from "@/modules/community/presentation/session"
import { BADGES, BADGE_CODES, POINTS_TABLE } from "@/modules/users/domain/badges"
import { LEVELS, levelOf } from "@/modules/users/domain/user"

export const metadata: Metadata = { title: "Classement des contributeurs" }

type LeaderboardProps = { searchParams: Promise<{ periode?: string }> }

const MEDALS = ["bg-brand", "bg-av-1", "bg-av-3"]
const CARD_TITLE = "mb-3 text-[13px] font-semibold"
const BADGES_SHOWN = 6

export default async function LeaderboardPage({ searchParams }: LeaderboardProps) {
  const { periode } = await searchParams
  const period = periode === "depuis-toujours" ? "depuis-toujours" : "mois"
  const [viewer, members] = await Promise.all([getSessionUser(), community().users.list()])
  const ranking = members
    .filter((member) => member.role === "member")
    .sort((a, b) => (period === "mois" ? b.month - a.month : b.points - a.points))

  return (
    <PageLayout
      active="leaderboard"
      right={
        <>
          <Card>
            <CardContent>
              <h2 className={CARD_TITLE}>Gagner des points</h2>
              <ul className="flex flex-col gap-2 text-sm">
                {POINTS_TABLE.map(([label, points]) => (
                  <li key={label} className="flex justify-between gap-2.5">
                    <span>{label}</span>
                    <b className="text-brand-text tabular-nums">+{points}</b>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
          <Card>
            <CardContent>
              <h2 className={CARD_TITLE}>Les niveaux</h2>
              <ul className="flex flex-col gap-2 text-sm">
                {LEVELS.map(([min, name]) => (
                  <li key={name} className="flex justify-between gap-2.5">
                    <span>{name}</span>
                    <b className="text-brand-text tabular-nums">{min}</b>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
          <Card>
            <CardContent>
              <h2 className={CARD_TITLE}>
                Badges à débloquer <NotePin k="rewards" />
              </h2>
              <div className="flex flex-col gap-2.5">
                {BADGE_CODES.slice(0, BADGES_SHOWN).map((code) => (
                  <div key={code} className="flex items-center gap-2.5">
                    <BadgeIcon code={code} />
                    <div className="text-[13.5px]">
                      <b className="font-semibold">{BADGES[code].name}</b>
                      <div className="text-[12.5px] text-ink-3">{BADGES[code].description}</div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </>
      }
    >
      <header>
        <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">
          Classement des contributeurs <NotePin k="top" />
        </h1>
        <p className="mt-1.5 max-w-[62ch] text-ink-2">
          Les membres qui font vivre la communauté. Aidez les autres, gagnez des points, montez de niveau.
        </p>
      </header>
      <QueryTabs
        param="periode"
        active={period}
        fallback="mois"
        tabs={[
          { value: "mois", label: "Ce mois-ci", icon: "calendar" },
          { value: "depuis-toujours", label: "Depuis toujours", icon: "trophy" },
        ]}
      />
      <Card className="gap-0 p-0">
        <ol>
          {ranking.map((member, index) => (
            <li
              key={member.username}
              className={cn(
                "flex items-center gap-3 border-t border-line px-[18px] py-3 first:border-t-0",
                viewer?.username === member.username && "bg-brand-soft"
              )}
            >
              <span className="w-[30px] text-center font-semibold text-ink-3 tabular-nums">
                {index < 3 ? (
                  <span
                    className={cn(
                      "inline-grid size-[26px] place-items-center rounded-full text-xs text-white tabular-nums",
                      MEDALS[index]
                    )}
                  >
                    {index + 1}
                  </span>
                ) : (
                  index + 1
                )}
              </span>
              <UserAvatar user={member} size="sm" link />
              <UserLink user={member} className="min-w-0 flex-1">
                <b className="block text-[14.5px] font-semibold">{member.name}</b>
                <small className="text-[12.5px] text-ink-3">{levelOf(member.points).name}</small>
              </UserLink>
              <span className="font-semibold text-brand-text tabular-nums">
                {period === "mois" ? `+${member.month}` : member.points} pts
              </span>
            </li>
          ))}
        </ol>
      </Card>
    </PageLayout>
  )
}
