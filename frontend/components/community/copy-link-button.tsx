"use client"

import { Link2 } from "lucide-react"

import { Button } from "@/components/ui/button"
import { useEffects } from "./effects"

export function CopyLinkButton() {
  const { showMessage } = useEffects()

  const copy = async () => {
    try {
      await navigator.clipboard.writeText(window.location.href)
    } catch {
    }
    showMessage("link", "Lien copié")
  }

  return (
    <Button variant="ghost" onClick={copy} className="h-8 gap-1.5 rounded-lg px-[11px] text-[13.5px] font-medium">
      <Link2 />
      Copier le lien
    </Button>
  )
}
