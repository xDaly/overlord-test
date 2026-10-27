import type { ReactNode } from "react"

import { DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { cn } from "@/lib/utils"

export function ModalHead({
  title,
  description,
  pin,
}: {
  title: string
  description: string
  pin?: ReactNode
}) {
  return (
    <DialogHeader>
      <DialogTitle>
        {title} {pin}
      </DialogTitle>
      <DialogDescription className="sr-only">{description}</DialogDescription>
    </DialogHeader>
  )
}

export function ModalBody({ className, children }: { className?: string; children: ReactNode }) {
  return (
    <div className={cn("flex flex-col gap-4 px-[22px] pt-4 pb-[22px] max-[760px]:px-4", className)}>{children}</div>
  )
}

export function Steps({ done }: { done: 1 | 2 }) {
  return (
    <div className="flex gap-1.5" aria-hidden="true">
      {[1, 2].map((step) => (
        <span key={step} className={cn("h-1 flex-1 rounded-full bg-fill-2", step <= done && "bg-brand")} />
      ))}
    </div>
  )
}

export function FieldError({ id, message }: { id?: string; message?: string }) {
  return message ? (
    <p id={id} className="text-[13px] text-destructive">
      {message}
    </p>
  ) : null
}

export const FIELD_LABEL = "text-sm font-semibold"
export const FIELD_HINT = "text-[12.5px] text-ink-3"
