import type { ReactNode } from "react"

import { cn } from "@/lib/utils"
import { listCategories } from "@/modules/categories/categories.container"
import { getSessionUser } from "@/modules/community/presentation/session"
import { Container } from "./container"
import { SideNav, type SideNavActive } from "./side-nav"

export async function PageLayout({
  active,
  right,
  children,
}: {
  active?: SideNavActive
  right?: ReactNode
  children: ReactNode
}) {
  const [user, categories] = await Promise.all([getSessionUser(), listCategories()])
  return (
    <Container>
      <div
        className={cn(
          "grid items-start gap-7 pt-6 pb-24 max-[760px]:grid-cols-[minmax(0,1fr)] max-[760px]:pt-4 max-[760px]:pb-[100px]",
          right
            ? "grid-cols-[212px_minmax(0,1fr)_304px] max-[1180px]:grid-cols-[200px_minmax(0,1fr)]"
            : "grid-cols-[212px_minmax(0,1fr)] max-[1180px]:grid-cols-[200px_minmax(0,1fr)]"
        )}
      >
        <SideNav active={active} categories={categories} interests={user?.interests ?? []} />
        <main id="main" className="flex min-w-0 flex-col gap-[18px]">
          {children}
        </main>
        {right ? (
          <aside className="flex min-w-0 flex-col gap-[18px] max-[1180px]:col-start-2 max-[760px]:col-start-1 max-[760px]:[&_.mobile-hidden]:hidden">
            {right}
          </aside>
        ) : null}
      </div>
    </Container>
  )
}
