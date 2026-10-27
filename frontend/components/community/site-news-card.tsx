import { ExternalLink, Newspaper } from "lucide-react"

import { buttonVariants } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { Separator } from "@/components/ui/separator"
import { cn } from "@/lib/utils"
import { NotePin } from "./notes"
import { SiteLink } from "./site-link"

const NEWS: [kicker: string, title: string, paid: boolean][] = [
  ["Diversifier vos placements", "Fonds euros : les rendements servis par les assureurs", true],
  ["Réussir en Bourse", "Les valeurs à surveiller cette semaine", true],
  ["Réduire vos impôts", "Déclaration de revenus : les cases à ne pas oublier", false],
]

export function SiteNewsCard() {
  return (
    <Card>
      <CardContent>
        <h2 className="mb-3 flex items-center gap-2 text-[13px] font-semibold">
          <Newspaper className="size-[18px] text-brand-text" />À la une sur lerevenu.com <NotePin k="site" />
        </h2>
        <div className="flex flex-col">
          {NEWS.map(([kicker, title, paid], index) => (
            <div key={title}>
              {index > 0 ? <Separator className="bg-line" /> : null}
              <SiteLink className={cn("group/news block py-3", index === 0 && "pt-0")}>
                <span className="mb-0.5 block text-xs font-semibold text-brand-text">{kicker}</span>
                <b className="text-[14.5px] font-semibold group-hover/news:text-brand-text">
                  {paid ? (
                    <span
                      title="Réservé aux abonnés"
                      className="mr-1.5 inline-grid size-4 place-items-center rounded-[4px] bg-sub align-[1px] text-[10px] font-extrabold text-sub-ink"
                    >
                      R
                    </span>
                  ) : null}
                  {title}
                </b>
              </SiteLink>
            </div>
          ))}
        </div>
        <div className="mt-3">
          <SiteLink className={cn(buttonVariants({ variant: "secondary", size: "sm" }), "w-full")}>
            Aller sur lerevenu.com
            <ExternalLink />
          </SiteLink>
        </div>
      </CardContent>
    </Card>
  )
}
