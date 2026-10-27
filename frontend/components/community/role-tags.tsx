import { BadgeCheck, Check, Shield } from "lucide-react"

import { Badge } from "@/components/ui/badge"
import { levelName, type User } from "@/modules/users/domain/user"

export function RoleTags({ user, withLevel = true }: { user: User; withLevel?: boolean }) {
  if (user.role === "redaction")
    return (
      <Badge variant="redaction">
        <Check />
        Rédaction
      </Badge>
    )
  if (user.role === "moderator")
    return (
      <Badge variant="question">
        <Shield />
        Modération
      </Badge>
    )
  return (
    <>
      {user.expertTitle ? (
        <Badge variant="expert">
          <BadgeCheck />
          Expertise vérifiée
        </Badge>
      ) : null}
      {user.subscriber ? <Badge variant="subscriber">Abonné</Badge> : null}
      {withLevel ? <Badge variant="level">{levelName(user.points)}</Badge> : null}
    </>
  )
}
