"use client"

import { PenLine } from "lucide-react"

import { Button } from "@/components/ui/button"
import { useDialogs } from "./dialogs/dialogs-context"

export function WriteBlogButton({ className }: { className?: string }) {
  const { openBlogEditor } = useDialogs()
  return (
    <Button variant="secondary" size="sm" className={className ?? "mt-3"} onClick={openBlogEditor}>
      <PenLine />
      Écrire un billet
    </Button>
  )
}
