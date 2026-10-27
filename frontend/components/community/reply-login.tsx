"use client"

import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { useDialogs } from "./dialogs/dialogs-context"

export function ReplyLogin({
  title,
  text,
  action,
}: {
  title: string
  text: string
  action: string
}) {
  const { openLogin } = useDialogs()
  return (
    <Card className="items-center gap-2.5 px-5 py-[26px] text-center">
      <h3 className="font-display text-[19px] font-bold tracking-[-.01em]">{title}</h3>
      <p className="text-ink-3">{text}</p>
      <Button onClick={openLogin}>{action}</Button>
    </Card>
  )
}
