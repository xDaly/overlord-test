import { EyeOff, Globe } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { seoStatus, type SeoInput } from "@/modules/discussions/domain/seo"

export function SeoPill({
  seo,
  staff,
  feminine = true,
  indexed,
  reason,
}: {
  seo?: SeoInput
  staff: boolean
  feminine?: boolean
  indexed?: boolean
  reason?: string
}) {
  if (!staff) return null
  const status = seo ? seoStatus(seo) : { on: Boolean(indexed), reason: reason ?? "" }
  return (
    <Badge variant={status.on ? "solved" : "muted"} title={status.reason}>
      {status.on ? <Globe /> : <EyeOff />}
      {status.on ? (feminine ? "Indexée" : "Indexé") : feminine ? "Non indexée" : "Non indexé"}
    </Badge>
  )
}
