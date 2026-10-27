"use client"

import { Camera, PenLine, Plus } from "lucide-react"

import { Button } from "@/components/ui/button"
import { useDialogs } from "./dialogs/dialogs-context"

export function PhotoEditButton() {
  const { openPhoto } = useDialogs()
  return (
    <Button
      variant="secondary"
      size="icon"
      aria-label="Changer la photo de profil"
      title="Changer la photo"
      onClick={openPhoto}
      className="absolute right-[-2px] bottom-[-2px] size-8 rounded-full bg-card text-foreground hover:text-brand-text [&_svg:not([class*='size-'])]:size-4"
    >
      <Camera />
    </Button>
  )
}

export function ProfileActions() {
  const { openBlogEditor, openProfileEditor } = useDialogs()
  return (
    <div className="flex flex-wrap gap-2">
      <Button onClick={openBlogEditor}>
        <PenLine />
        Écrire un billet
      </Button>
      <Button variant="secondary" onClick={openProfileEditor}>
        Modifier le profil
      </Button>
    </div>
  )
}

export function EmptyAction({ kind }: { kind: "blog" | "discussion" }) {
  const { openBlogEditor, openComposer } = useDialogs()
  return kind === "blog" ? (
    <Button className="mt-3.5" onClick={openBlogEditor}>
      <PenLine />
      Écrire un billet
    </Button>
  ) : (
    <Button className="mt-3.5" onClick={() => openComposer()}>
      <Plus />
      Publier
    </Button>
  )
}
