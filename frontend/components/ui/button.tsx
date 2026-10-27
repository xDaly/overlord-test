import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "cn"

const buttonVariants = cva(
  "group/button inline-flex shrink-0 items-center justify-center rounded-md border border-transparent bg-clip-padding text-sm font-semibold whitespace-nowrap transition-[background-color,box-shadow,filter,transform] outline-none select-none focus-visible:ring-3 focus-visible:ring-brand/45 active:not-aria-[haspopup]:scale-[.98] disabled:pointer-events-none disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-[18px]",
  {
    variants: {
      variant: {
        default:
          "bg-gradient-to-b from-[color-mix(in_srgb,var(--brand)_82%,#fff)] to-brand text-primary-foreground shadow-[inset_0_1px_0_rgba(255,255,255,.22),0_1px_2px_color-mix(in_srgb,var(--brand)_35%,transparent)] hover:brightness-[.93]",
        outline:
          "border-border bg-background hover:bg-muted hover:text-foreground aria-expanded:bg-muted aria-expanded:text-foreground",
        secondary:
          "border-hairline bg-card text-foreground shadow-[0_1px_2px_rgba(0,0,0,.06)] hover:bg-surface-2",
        ghost:
          "text-ink-2 hover:bg-fill hover:text-foreground aria-expanded:bg-fill aria-expanded:text-foreground",
        destructive:
          "bg-destructive/10 text-destructive hover:bg-destructive/20 focus-visible:ring-destructive/20",
        link: "text-brand-text underline-offset-4 hover:underline",
      },
      size: {
        default: "h-9 gap-[7px] px-4",
        xs: "h-6 gap-1 rounded-md px-2 text-xs [&_svg:not([class*='size-'])]:size-3",
        sm: "h-[30px] gap-[7px] rounded-lg px-3 text-[13px] [&_svg:not([class*='size-'])]:size-4",
        lg: "h-10 gap-[7px] px-5",
        icon: "size-9 rounded-[9px]",
        "icon-xs": "size-6 rounded-md [&_svg:not([class*='size-'])]:size-3",
        "icon-sm": "size-8 rounded-lg",
        "icon-lg": "size-10 rounded-[9px]",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  ...props
}: ButtonPrimitive.Props & VariantProps<typeof buttonVariants>) {
  return (
    <ButtonPrimitive
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
