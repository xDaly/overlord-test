import { ArrowDownWideNarrow, ArrowUpNarrowWide, ChevronLeft, ChevronRight } from "lucide-react"
import Link from "next/link"

import { cn } from "@/lib/utils"
import type { DiscussionOrder } from "@/modules/discussions/domain/discussion"
import { hrefWith, ORDER_PARAM } from "@/modules/discussions/presentation/feed-paging"

type Params = Record<string, string | undefined>

const CONTROL =
  "inline-flex items-center gap-1.5 rounded-lg border border-hairline bg-card px-3 py-1.5 text-[13.5px] font-medium text-ink-2 shadow-card transition-colors hover:text-foreground aria-[current=true]:border-brand aria-[current=true]:text-brand-text"

export function FeedSort({ basePath, params, order }: { basePath: string; params: Params; order?: DiscussionOrder }) {
  const options: { value: DiscussionOrder; label: string; Icon: typeof ArrowDownWideNarrow }[] = [
    { value: "newest", label: "Plus récentes", Icon: ArrowDownWideNarrow },
    { value: "oldest", label: "Plus anciennes", Icon: ArrowUpNarrowWide },
  ]
  return (
    <nav aria-label="Trier par date de publication" className="flex flex-wrap items-center gap-2 text-[13px] text-ink-3">
      <span>Trier par date :</span>
      {options.map(({ value, label, Icon }) => (
        <Link
          key={value}
          href={hrefWith(basePath, params, { ordre: ORDER_PARAM[value], page: undefined })}
          aria-current={order === value}
          className={CONTROL}
          scroll={false}
        >
          <Icon className="size-4" />
          {label}
        </Link>
      ))}
    </nav>
  )
}

export function FeedPager({
  basePath,
  params,
  page,
  pageCount,
  total,
}: {
  basePath: string
  params: Params
  page: number
  pageCount: number
  total: number
}) {
  if (pageCount <= 1) return null
  const link = (target: number, label: string, disabled: boolean, children: React.ReactNode) =>
    disabled ? (
      <span aria-disabled="true" aria-label={label} className={cn(CONTROL, "pointer-events-none opacity-40")}>
        {children}
      </span>
    ) : (
      <Link href={hrefWith(basePath, params, { page: target === 1 ? undefined : String(target) })} aria-label={label} className={CONTROL} scroll>
        {children}
      </Link>
    )
  return (
    <nav aria-label="Pagination des discussions" className="flex items-center justify-between gap-3">
      {link(page - 1, "Page précédente", page <= 1, (
        <>
          <ChevronLeft className="size-4" />
          Précédente
        </>
      ))}
      <span className="text-[13px] text-ink-3 tabular-nums">
        Page {page} sur {pageCount} · {total} discussions
      </span>
      {link(page + 1, "Page suivante", page >= pageCount, (
        <>
          Suivante
          <ChevronRight className="size-4" />
        </>
      ))}
    </nav>
  )
}
