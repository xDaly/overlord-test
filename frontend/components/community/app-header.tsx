import Link from "next/link"
import { Suspense } from "react"

import { Separator } from "@/components/ui/separator"
import type { Notification } from "@/modules/notifications/domain/notification"
import type { User } from "@/modules/users/domain/user"
import { Container } from "./container"
import { HeaderActions } from "./header-actions"
import { HeaderSearch } from "./header-search"
import { LrLogo } from "./lr-logo"

export function AppHeader({
  notifications,
  actors,
}: {
  notifications: Notification[]
  actors: Record<string, User>
}) {
  return (
    <header className="sticky top-0 z-40 border-b border-hairline bg-glass backdrop-blur-[20px] backdrop-saturate-[180%]">
      <Container className="flex h-[62px] items-center gap-5">
        <Link
          href="/"
          aria-label="Le Revenu, accueil de la communauté"
          className="flex flex-none items-center gap-2.5 max-[760px]:flex-col max-[760px]:items-start max-[760px]:gap-1"
        >
          <LrLogo />
          <Separator orientation="vertical" className="h-5 w-px bg-line-strong max-[760px]:hidden" />
          <span className="text-[15px] font-semibold text-ink-2 max-[760px]:text-xs">Communauté</span>
        </Link>
        <Suspense>
          <HeaderSearch />
        </Suspense>
        <HeaderActions notifications={notifications} actors={actors} />
      </Container>
    </header>
  )
}
