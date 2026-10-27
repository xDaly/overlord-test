import * as React from "react"
import { cn } from "cn"

function Textarea({ className, ...props }: React.ComponentProps<"textarea">) {
  return (
    <textarea
      data-slot="textarea"
      className={cn(
        "flex min-h-[110px] w-full resize-y rounded-[9px] border border-line bg-card px-3.5 py-3 text-[15px] leading-normal transition-[border-color,box-shadow] outline-none placeholder:text-ink-3 focus-visible:border-brand focus-visible:ring-3 focus-visible:ring-brand/25 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-destructive",
        className
      )}
      {...props}
    />
  )
}

export { Textarea }
