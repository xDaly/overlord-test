import { ChartColumn, Check, Pin } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { isWithin } from "@/lib/format/relative-time"
import type { Discussion } from "@/modules/discussions/domain/discussion"
import { SeoPill } from "./seo-pill"

const NEW_WINDOW_MS = 6 * 3_600_000

type TaggedDiscussion = Pick<
  Discussion,
  "type" | "solutionId" | "pinned" | "repliesCount" | "createdAt" | "seo"
>

export function TypeTag({ discussion }: { discussion: Pick<Discussion, "type" | "solutionId"> }) {
  if (discussion.type === "question")
    return discussion.solutionId ? (
      <Badge variant="solved">
        <Check />
        Résolu
      </Badge>
    ) : (
      <Badge variant="question">Question</Badge>
    )
  if (discussion.type === "poll")
    return (
      <Badge variant="poll">
        <ChartColumn />
        Sondage
      </Badge>
    )
  return null
}

export function DiscussionTags({ discussion, staff }: { discussion: TaggedDiscussion; staff: boolean }) {
  const isNew = discussion.repliesCount === 0 && isWithin(discussion.createdAt, NEW_WINDOW_MS)
  return (
    <>
      <TypeTag discussion={discussion} />
      {discussion.pinned ? (
        <Badge variant="pinned">
          <Pin />
          Épinglé
        </Badge>
      ) : null}
      {isNew ? <Badge variant="new">Nouveau</Badge> : null}
      <SeoPill seo={discussion.seo} staff={staff} />
    </>
  )
}
