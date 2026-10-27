"use client"

import {
  Calendar,
  CircleHelp,
  Clock,
  MessageCircle,
  PenLine,
  Reply,
  Sparkles,
  TrendingUp,
  Trophy,
} from "lucide-react"
import { usePathname, useRouter, useSearchParams } from "next/navigation"

import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs"

const TAB_ICONS = {
  sparkles: Sparkles,
  trend: TrendingUp,
  clock: Clock,
  help: CircleHelp,
  pen: PenLine,
  message: MessageCircle,
  reply: Reply,
  trophy: Trophy,
  calendar: Calendar,
} as const

export type TabIcon = keyof typeof TAB_ICONS

export type QueryTab = {
  value: string
  label: string
  icon: TabIcon
  count?: number
  countTone?: "alert" | "muted"
}

export function QueryTabs({
  param,
  active,
  fallback,
  tabs,
}: {
  param: string
  active: string
  fallback: string
  tabs: QueryTab[]
}) {
  const router = useRouter()
  const pathname = usePathname()
  const searchParams = useSearchParams()

  const handleChange = (value: unknown) => {
    const params = new URLSearchParams(searchParams.toString())
    if (value === fallback) params.delete(param)
    else params.set(param, String(value))
    params.delete("page")
    const query = params.toString()
    router.push(query ? `${pathname}?${query}` : pathname, { scroll: false })
  }

  return (
    <Tabs value={active} onValueChange={handleChange} className="min-w-0">
      <TabsList className="h-auto max-w-full [scrollbar-width:none] gap-0.5 self-start overflow-x-auto rounded-[10px] bg-fill p-[3px]">
        {tabs.map(({ value, label, icon, count, countTone = "alert" }) => {
          const Icon = TAB_ICONS[icon]
          return (
            <TabsTrigger
              key={value}
              value={value}
              className="h-auto flex-none gap-[7px] rounded-lg px-3.5 py-1.5 text-sm font-medium text-ink-2 hover:text-foreground data-active:bg-card data-active:font-semibold data-active:text-foreground data-active:shadow-[0_1px_3px_rgba(0,0,0,.12),0_0_0_.5px_rgba(0,0,0,.04)] dark:data-active:border-transparent dark:data-active:bg-card [&_svg:not([class*='size-'])]:size-[18px]"
            >
              <Icon />
              {label}
              {count !== undefined && (count > 0 || countTone === "muted") ? (
                <span
                  className={
                    countTone === "alert"
                      ? "rounded-full bg-alert-soft px-[7px] py-px text-[11.5px] font-medium text-destructive tabular-nums"
                      : "text-xs font-medium text-ink-3 tabular-nums"
                  }
                >
                  {count}
                </span>
              ) : null}
            </TabsTrigger>
          )
        })}
      </TabsList>
    </Tabs>
  )
}
