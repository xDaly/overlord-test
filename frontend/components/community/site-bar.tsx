import { BookOpen, ChevronLeft } from "lucide-react"

import { cn } from "@/lib/utils"
import type { User } from "@/modules/users/domain/user"
import { Container } from "./container"
import { NotePin } from "./notes"
import { SiteLink } from "./site-link"

const SITE_NAV = ["Bourse", "Économie", "Placements", "Immobilier", "Impôts", "Succession", "Vie pratique"]

const LINK = "inline-flex items-center gap-1.5 whitespace-nowrap hover:text-brand-text"

export function SiteBar({ user }: { user: User | null }) {
  const subscriber = Boolean(user?.subscriber)
  return (
    <div className="border-b border-hairline bg-card text-[13px] text-ink-2">
      <Container className="flex h-[38px] items-center gap-5">
        <SiteLink className={cn(LINK, "font-semibold text-foreground")}>
          <ChevronLeft className="size-[15px]" />
          Retour sur lerevenu.com
        </SiteLink>
        <NotePin k="site" />
        <nav
          aria-label="Rubriques de lerevenu.com"
          className="flex min-w-0 gap-4 overflow-hidden border-l border-line pl-5 max-[1100px]:hidden"
        >
          {SITE_NAV.map((rubrique) => (
            <SiteLink key={rubrique} className={LINK}>
              {rubrique}
            </SiteLink>
          ))}
        </nav>
        <span className="ml-auto flex items-center gap-4">
          <SiteLink className={cn(LINK, "max-[760px]:hidden")}>
            <BookOpen className="size-[15px]" />
            Le magazine
          </SiteLink>
          <SiteLink
            className={cn(
              LINK,
              "rounded-full px-[11px] py-[3px] font-semibold",
              subscriber
                ? "bg-fill text-foreground hover:text-foreground"
                : "bg-brand text-white hover:text-white hover:brightness-[.93]"
            )}
          >
            {subscriber ? "Mon abonnement" : "S'abonner"}
          </SiteLink>
        </span>
      </Container>
    </div>
  )
}
