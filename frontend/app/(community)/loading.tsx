import { PageLayout } from "@/components/community/page-layout"
import { Skeleton } from "@/components/ui/skeleton"

export default function Loading() {
  return (
    <PageLayout>
      <Skeleton className="h-14 rounded-lg" />
      <Skeleton className="h-9 w-72 rounded-[10px]" />
      <div className="flex flex-col overflow-hidden rounded-lg border border-hairline bg-card shadow-card">
        {Array.from({ length: 5 }, (_, index) => (
          <div key={index} className="grid grid-cols-[62px_minmax(0,1fr)] gap-4 border-t border-line px-[18px] py-4 first:border-t-0">
            <Skeleton className="h-[58px] w-[62px] rounded-[9px]" />
            <div className="flex flex-col gap-2">
              <Skeleton className="h-3.5 w-32" />
              <Skeleton className="h-5 w-3/4" />
              <Skeleton className="h-4 w-full" />
            </div>
          </div>
        ))}
      </div>
    </PageLayout>
  )
}
