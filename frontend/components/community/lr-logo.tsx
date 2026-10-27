import { cn } from "@/lib/utils"

export function LrLogo({ className }: { className?: string }) {
  const word = "px-[.1em] pt-[.1em] pb-[.12em] text-[1em] leading-none font-black tracking-[-.02em] text-white"
  return (
    <span
      className={cn(
        "inline-flex flex-none items-stretch bg-brand p-[.1em] text-[22px] max-[760px]:text-[19px]",
        className
      )}
      aria-hidden="true"
    >
      <span className={cn(word, "mr-[.12em] bg-black")}>LE</span>
      <span className={word}>REVENU</span>
    </span>
  )
}
