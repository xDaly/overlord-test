"use client"

import { List, LayoutList } from "lucide-react"
import { useState, type ReactNode } from "react"

import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group"
import { FEED_TAB_LABELS, type FeedTab } from "@/modules/discussions/presentation/feed-tab"
import { NotePin } from "./notes"
import { QueryTabs, type TabIcon } from "./query-tabs"

type Density = "comfy" | "compact"

const ICONS: Record<FeedTab, TabIcon> = {
  "pour-vous": "sparkles",
  tendances: "trend",
  recentes: "clock",
  "sans-reponse": "help",
}

const DENSITY_ITEM =
  "h-[30px] w-[34px] min-w-0 rounded-lg p-0 text-ink-3 hover:bg-transparent hover:text-foreground data-pressed:bg-card data-pressed:text-foreground data-pressed:shadow-[0_1px_3px_rgba(0,0,0,.12),0_0_0_.5px_rgba(0,0,0,.04)] [&_svg:not([class*='size-'])]:size-[17px]"

export function FeedSection({
  tabs,
  active,
  fallback,
  unansweredCount,
  initialDensity,
  comfortable,
  compact,
}: {
  tabs: FeedTab[]
  active: FeedTab
  fallback: FeedTab
  unansweredCount: number
  initialDensity: Density
  comfortable: ReactNode
  compact: ReactNode
}) {
  const [density, setDensity] = useState<Density>(initialDensity)

  const change = (next: Density) => {
    setDensity(next)
    try {
      document.cookie = `lr-density=${next}; path=/; max-age=31536000; samesite=lax`
    } catch {
    }
  }

  return (
    <>
      <div className="flex items-center justify-between gap-3">
        <div className="flex min-w-0 items-center gap-1">
          <QueryTabs
            param="tri"
            active={active}
            fallback={fallback}
            tabs={tabs.map((tab) => ({
              value: tab,
              label: FEED_TAB_LABELS[tab],
              icon: ICONS[tab],
              count: tab === "sans-reponse" ? unansweredCount : undefined,
            }))}
          />
          <NotePin k="tabs" />
        </div>
        <span className="flex items-center gap-1.5">
          <NotePin k="density" />
          <ToggleGroup
            value={[density]}
            onValueChange={(value) => value[0] && change(value[0] as Density)}
            spacing={0}
            aria-label="Affichage de la liste"
            className="gap-0.5 rounded-[10px] bg-fill p-[3px]"
          >
            <ToggleGroupItem value="comfy" aria-label="Vue détaillée" title="Vue détaillée" className={DENSITY_ITEM}>
              <LayoutList />
            </ToggleGroupItem>
            <ToggleGroupItem value="compact" aria-label="Vue compacte" title="Vue compacte" className={DENSITY_ITEM}>
              <List />
            </ToggleGroupItem>
          </ToggleGroup>
        </span>
      </div>
      {density === "compact" ? compact : comfortable}
    </>
  )
}
