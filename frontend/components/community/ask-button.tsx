"use client"

import { Plus } from "lucide-react"

import { Button } from "@/components/ui/button"
import { useDialogs } from "./dialogs/dialogs-context"

export function AskButton({ title }: { title: string }) {
  const { openComposer } = useDialogs()
  return (
    <Button className="mt-3.5" onClick={() => openComposer({ type: "question", title })}>
      <Plus />
      Poser cette question
    </Button>
  )
}
