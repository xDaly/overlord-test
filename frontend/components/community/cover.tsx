import { Globe, PenLine } from "lucide-react"

import { cn } from "@/lib/utils"
import type { Category } from "@/modules/categories/domain/category"
import { CATEGORY_ICONS } from "./category-icon"

const KINDS = {
  card: "aspect-[4/3] self-start rounded-xl [&_svg]:size-9",
  thumb: "size-11 rounded-[10px] [&_svg]:size-5",
  hero: "mb-[18px] h-[150px] rounded-xl [&_svg]:size-14",
} as const

export function BlogCover({ category, kind }: { category: Category | null; kind: keyof typeof KINDS }) {
  const color = category?.color ?? "var(--blog)"
  const Icon = category ? (CATEGORY_ICONS[category.icon] ?? Globe) : PenLine
  return (
    <div
      aria-hidden="true"
      className={cn(
        "grid shrink-0 place-items-center text-white shadow-[inset_0_1px_0_rgba(255,255,255,.25)] [&_svg]:opacity-90",
        KINDS[kind]
      )}
      style={{ background: `radial-gradient(120% 120% at 0% 0%, color-mix(in srgb, ${color} 55%, #fff), ${color})` }}
    >
      <Icon />
    </div>
  )
}
