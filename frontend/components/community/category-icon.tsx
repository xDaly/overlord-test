import {
  Armchair,
  Building2,
  ChartCandlestick,
  Coffee,
  Gem,
  Globe,
  Receipt,
  PiggyBank,
  Umbrella,
  Users,
  Wallet,
  type LucideIcon,
} from "lucide-react"

import { cn } from "@/lib/utils"
import type { Category } from "@/modules/categories/domain/category"

export const CATEGORY_ICONS: Record<string, LucideIcon> = {
  candles: ChartCandlestick,
  globe: Globe,
  piggy: PiggyBank,
  umbrella: Umbrella,
  building: Building2,
  receipt: Receipt,
  armchair: Armchair,
  family: Users,
  gem: Gem,
  wallet: Wallet,
  coffee: Coffee,
}

const SIZES = {
  sm: "size-[22px] rounded-[6px] [&_svg]:size-[13px]",
  md: "size-10 rounded-[11px] [&_svg]:size-6",
  lg: "size-14 rounded-[15px] [&_svg]:size-[34px]",
} as const

export function CategoryIcon({
  category,
  size = "sm",
  className,
}: {
  category: Pick<Category, "icon" | "color">
  size?: keyof typeof SIZES
  className?: string
}) {
  const Icon = CATEGORY_ICONS[category.icon] ?? Globe
  return (
    <span
      className={cn(
        "inline-grid shrink-0 place-items-center text-white shadow-[inset_0_.5px_0_rgba(255,255,255,.35),0_.5px_1.5px_rgba(0,0,0,.18)] [&_svg]:stroke-[2.2]",
        SIZES[size],
        className
      )}
      style={{
        background: `linear-gradient(180deg, color-mix(in srgb, ${category.color} 78%, #fff), ${category.color})`,
      }}
      aria-hidden="true"
    >
      <Icon />
    </span>
  )
}
