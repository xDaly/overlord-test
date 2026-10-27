import { mergeProps } from "@base-ui/react/merge-props"
import { useRender } from "@base-ui/react/use-render"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "cn"

const badgeVariants = cva(
  "group/badge inline-flex w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-full border border-transparent px-2 py-px text-[11.5px] leading-normal font-semibold whitespace-nowrap [&>svg]:pointer-events-none [&>svg]:size-3",
  {
    variants: {
      variant: {
        default: "bg-fill text-ink-2",
        question: "bg-fill text-ink-2",
        solved: "bg-ok-soft text-ok",
        poll: "bg-brand-soft text-brand-text",
        pinned: "bg-fill text-ink-2",
        redaction: "bg-redac text-card",
        subscriber: "bg-sub text-sub-ink",
        level: "bg-fill font-medium text-ink-2",
        new: "bg-brand text-primary-foreground",
        expert: "bg-pro/13 text-pro",
        muted: "bg-fill text-ink-3",
        blog: "bg-blog/13 text-blog",
        solid: "bg-primary text-primary-foreground",
        outline: "border-border text-foreground",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

function Badge({
  className,
  variant = "default",
  render,
  ...props
}: useRender.ComponentProps<"span"> & VariantProps<typeof badgeVariants>) {
  return useRender({
    defaultTagName: "span",
    props: mergeProps<"span">(
      {
        className: cn(badgeVariants({ variant }), className),
      },
      props
    ),
    render,
    state: {
      slot: "badge",
      variant,
    },
  })
}

export { Badge, badgeVariants }
