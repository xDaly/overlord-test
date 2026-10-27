"use client"

import Link from "next/link"

import { Button } from "@/components/ui/button"
import type { CommunityStats } from "@/modules/community/application/community-stats"
import { useDialogs } from "./dialogs/dialogs-context"
import { NotePin } from "./notes"

const number = (value: number) => value.toLocaleString("fr-FR")

function statsOf({ members, discussions, replies, resolvedPercent }: CommunityStats): [string, string][] {
  const stats: [string, string][] = [
    [number(members), "membres"],
    [number(discussions), "discussions"],
    [number(replies), "réponses"],
  ]
  if (resolvedPercent !== null) stats.push([`${resolvedPercent} %`, "des questions résolues"])
  return stats
}

export function Hero({ stats }: { stats: CommunityStats }) {
  const { openLogin } = useDialogs()
  return (
    <section className="relative grid grid-cols-[minmax(0,1fr)_auto] items-end gap-x-6 gap-y-[18px] overflow-hidden rounded-[18px] bg-[radial-gradient(120%_140%_at_100%_0%,color-mix(in_srgb,var(--brand)_55%,transparent)_0%,transparent_55%),linear-gradient(160deg,var(--hero-top),var(--hero))] px-7 pt-7 pb-6 text-white shadow-pop max-[760px]:grid-cols-[minmax(0,1fr)] max-[760px]:rounded-2xl max-[760px]:px-5 max-[760px]:py-[22px]">
      <div>
        <h1 className="max-w-[22ch] font-display text-[32px] leading-[1.12] font-bold tracking-[-.01em] max-[760px]:text-[25px]">
          La communauté des lecteurs du Revenu <NotePin k="visitor" />
        </h1>
        <p className="mt-2 max-w-[52ch] text-white/78">
          Posez vos questions d&apos;argent, partagez vos expériences et échangez avec la rédaction. Bourse, épargne,
          impôts, retraite, transmission.
        </p>
        <div className="mt-4 flex flex-wrap gap-[22px] text-[13px] opacity-90">
          {statsOf(stats).map(([value, label]) => (
            <span key={label}>
              <b className="block text-xl font-bold text-white tabular-nums">{value}</b>
              {label}
            </span>
          ))}
        </div>
      </div>
      <div className="flex flex-col gap-2 max-[760px]:flex-row max-[760px]:flex-wrap">
        <Button onClick={openLogin} className="hover:brightness-[1.08]">
          Rejoindre gratuitement
        </Button>
        <Button
          variant="ghost"
          nativeButton={false}
          render={<Link href="/espaces" />}
          className="border-white/18 bg-white/14 text-white backdrop-blur-[10px] hover:bg-white/24 hover:text-white"
        >
          Explorer les espaces
        </Button>
      </div>
    </section>
  )
}
