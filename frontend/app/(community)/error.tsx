"use client"

import { Button } from "@/components/ui/button"
import { Container } from "@/components/community/container"

export default function CommunityError({ reset }: { error: Error; reset: () => void }) {
  return (
    <Container className="py-10">
      <div className="rounded-lg border border-hairline bg-card px-5 py-10 text-center text-ink-2 shadow-card">
        <h1 className="mb-1.5 font-display text-xl font-bold tracking-[-.01em] text-foreground">
          Le contenu n&apos;a pas pu être chargé
        </h1>
        <p>Une erreur est survenue. Vous pouvez réessayer dans un instant.</p>
        <Button className="mt-3.5" onClick={reset}>
          Réessayer
        </Button>
      </div>
    </Container>
  )
}
