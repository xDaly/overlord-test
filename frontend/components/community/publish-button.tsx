"use client"

import { Plus } from "lucide-react"
import type { ComponentProps } from "react"

import { Button } from "@/components/ui/button"
import { useDialogs } from "./dialogs/dialogs-context"

export function PublishButton({
  category,
  children,
  ...props
}: { category: string } & Omit<ComponentProps<typeof Button>, "onClick">) {
  const { openComposer } = useDialogs()
  return (
    <Button onClick={() => openComposer({ category })} {...props}>
      <Plus />
      {children}
    </Button>
  )
}
