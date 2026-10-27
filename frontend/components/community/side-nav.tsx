import { BookOpen, ExternalLink, House, LayoutGrid, Trophy, type LucideIcon } from "lucide-react"
import Link from "next/link"

import { cn } from "@/lib/utils"
import type { Category } from "@/modules/categories/domain/category"
import { CategoryIcon } from "./category-icon"
import { SiteLink } from "./site-link"

export type SideNavActive = "home" | "spaces" | "leaderboard" | "charter" | { category: string }

const ITEM =
  "flex items-center gap-[11px] rounded-[9px] px-2.5 py-[7px] text-sm font-medium text-ink-2 hover:bg-fill hover:text-foreground"
const ITEM_ON = "bg-fill-2 font-semibold text-foreground"

function NavItem({
  href,
  active,
  icon: Icon,
  children,
}: {
  href: string
  active: boolean
  icon: LucideIcon
  children: string
}) {
  return (
    <Link href={href} className={cn(ITEM, active && ITEM_ON)} aria-current={active ? "page" : undefined}>
      <Icon className={cn("size-[18px] shrink-0", active && "text-brand-text")} />
      {children}
    </Link>
  )
}

export function SideNav({
  active,
  categories,
  interests,
}: {
  active?: SideNavActive
  categories: Category[]
  interests: string[]
}) {
  return (
    <nav
      aria-label="Navigation principale"
      className="sticky top-[86px] flex flex-col gap-0.5 max-[760px]:hidden"
    >
      <NavItem href="/" icon={House} active={active === "home"}>
        Accueil
      </NavItem>
      <NavItem href="/espaces" icon={LayoutGrid} active={active === "spaces"}>
        Tous les espaces
      </NavItem>
      <NavItem href="/classement" icon={Trophy} active={active === "leaderboard"}>
        Classement
      </NavItem>
      <NavItem href="/charte" icon={BookOpen} active={active === "charter"}>
        Charte
      </NavItem>
      <div className="px-2.5 pt-[18px] pb-1.5 text-[11.5px] font-semibold text-ink-3">Espaces</div>
      {categories.map((category) => {
        const on = typeof active === "object" && active.category === category.slug
        return (
          <Link
            key={category.slug}
            href={`/espaces/${category.slug}`}
            className={cn(ITEM, on && ITEM_ON)}
            aria-current={on ? "page" : undefined}
          >
            <CategoryIcon category={category} />
            {category.name}
            {interests.includes(category.slug) ? (
              <span className="ml-auto size-1.5 rounded-full bg-brand" title="Dans vos centres d'intérêt" />
            ) : null}
          </Link>
        )
      })}
      <SiteLink className="mt-[18px] flex items-center gap-2 border-t border-hairline px-2.5 pt-3 text-[13px] text-ink-3 hover:text-brand-text">
        <span>Retour sur lerevenu.com</span>
        <ExternalLink className="ml-auto size-[13px]" />
      </SiteLink>
    </nav>
  )
}
