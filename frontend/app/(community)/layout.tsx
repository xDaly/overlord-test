import type { ReactNode } from "react"

import { AppHeader } from "@/components/community/app-header"
import { BottomNav } from "@/components/community/bottom-nav"
import { CommunityProvider } from "@/components/community/community-context"
import { DialogsProvider } from "@/components/community/dialogs/dialogs-context"
import { NotesProvider } from "@/components/community/notes"
import { SiteBar } from "@/components/community/site-bar"
import { Toaster } from "@/components/ui/sonner"
import { listCategories } from "@/modules/categories/categories.container"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"

export const dynamic = "force-dynamic"

export default async function CommunityLayout({ children }: { children: ReactNode }) {
  const deps = community()
  const [user, flags, users, similar, categories] = await Promise.all([
    getSessionUser(),
    getViewFlags(),
    deps.users.list(),
    deps.discussions.similarCandidates(),
    listCategories(),
  ])
  const notifications = user ? await deps.notifications.list() : []
  const actors = Object.fromEntries(users.map((member) => [member.username, member]))

  return (
    <CommunityProvider value={{ user, users, categories, similar, staff: flags.staff }}>
      <NotesProvider>
        <DialogsProvider>
          <SiteBar user={user} />
          <AppHeader notifications={notifications} actors={actors} />
          {children}
          <BottomNav notifications={notifications} actors={actors} />
          <Toaster
            position="bottom-right"
            offset={16}
            mobileOffset={{ bottom: 80, right: 16, left: 16 }}
            toastOptions={{ unstyled: true }}
          />
        </DialogsProvider>
      </NotesProvider>
    </CommunityProvider>
  )
}
