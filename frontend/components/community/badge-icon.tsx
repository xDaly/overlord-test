import {
  ChartColumn,
  Check,
  Flame,
  Hand,
  Landmark,
  MessageCircle,
  PenLine,
  Star,
  ThumbsUp,
  Vote,
  type LucideIcon,
} from "lucide-react"

import { cn } from "@/lib/utils"
import { BADGES, type BadgeCode } from "@/modules/users/domain/badges"

const ICONS: Record<(typeof BADGES)[BadgeCode]["icon"], LucideIcon> = {
  hand: Hand,
  pen: PenLine,
  msg: MessageCircle,
  thumb: ThumbsUp,
  star: Star,
  check: Check,
  chart: ChartColumn,
  vote: Vote,
  flame: Flame,
  columns: Landmark,
}

export function BadgeIcon({
  code,
  size = "sm",
  locked = false,
  className,
}: {
  code: BadgeCode
  size?: "sm" | "lg"
  locked?: boolean
  className?: string
}) {
  const Icon = ICONS[BADGES[code].icon]
  return (
    <span
      title={BADGES[code].name}
      className={cn(
        "inline-grid shrink-0 place-items-center rounded-full bg-brand-soft text-brand-text",
        size === "lg" ? "size-[52px] [&_svg]:size-6" : "size-[30px] [&_svg]:size-4",
        locked && "bg-surface-2 text-ink-3 opacity-70",
        className
      )}
    >
      <Icon />
    </span>
  )
}
