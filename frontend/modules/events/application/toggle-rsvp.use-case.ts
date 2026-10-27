import { AppError } from "@/lib/errors"
import type { CommunityDeps } from "@/modules/community/application/deps"
import type { User } from "@/modules/users/domain/user"

export async function toggleRsvp(
  deps: Pick<CommunityDeps, "events">,
  viewer: User | null,
  eventId: string
): Promise<{ joined: boolean }> {
  if (!viewer) throw new AppError("unauthenticated")
  const joined = await deps.events.toggleRsvp(eventId)
  if (joined === null) throw new AppError("not-found")
  return { joined }
}
