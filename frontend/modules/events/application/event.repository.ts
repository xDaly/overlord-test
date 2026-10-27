import type { CommunityEvent } from "../domain/event"

export interface EventRepository {
  list(options?: { categorySlug?: string }): Promise<CommunityEvent[]>
  toggleRsvp(eventId: string): Promise<boolean | null>
}
