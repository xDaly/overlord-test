import Link from "next/link"

import { PageLayout } from "@/components/community/page-layout"
import { Button } from "@/components/ui/button"

export default function DiscussionNotFound() {
  return (
    <PageLayout>
      <div className="rounded-lg border border-hairline bg-card px-5 py-10 text-center text-ink-2 shadow-card">
        <h1 className="mb-1.5 font-display text-xl font-bold tracking-[-.01em] text-foreground">
          Cette discussion n&apos;existe pas
        </h1>
        <p>Elle a peut-être été supprimée, ou le lien est incorrect.</p>
        <Button className="mt-3.5" nativeButton={false} render={<Link href="/" />}>
          Retour à l&apos;accueil
        </Button>
      </div>
    </PageLayout>
  )
}
