import Link from "next/link"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import type { Category } from "@/modules/categories/domain/category"

const CHIP =
  "h-auto flex-none rounded-full border-hairline bg-card px-[13px] py-1.5 text-[13.5px] font-medium text-ink-2 shadow-[0_1px_2px_rgba(0,0,0,.04)] hover:bg-card"
const CHIP_ON = "border-brand bg-brand text-primary-foreground hover:bg-brand"

export function CatScroller({ categories, active }: { categories: Category[]; active?: string }) {
  return (
    <div className="hidden gap-2 overflow-x-auto pb-0.5 [scrollbar-width:none] max-[760px]:flex">
      <Button variant="secondary" nativeButton={false} render={<Link href="/" />} className={cn(CHIP, !active && CHIP_ON)}>
        Tout
      </Button>
      {categories.map((category) => (
        <Button
          key={category.slug}
          variant="secondary"
          nativeButton={false}
          render={<Link href={`/espaces/${category.slug}`} />}
          className={cn(CHIP, active === category.slug && CHIP_ON)}
        >
          {category.name}
        </Button>
      ))}
    </div>
  )
}
