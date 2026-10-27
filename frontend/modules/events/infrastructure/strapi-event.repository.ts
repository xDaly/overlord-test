import { AppError } from "@/lib/errors"
import type { StrapiClient, StrapiList } from "@/lib/strapi-client"
import type { StrapiParams } from "@/lib/strapi-query"
import type { Viewer } from "@/modules/discussions/infrastructure/strapi-discussion.repository"
import type { EventRepository } from "../application/event.repository"
import type { CommunityEvent } from "../domain/event"

export type StrapiEventEntry = {
  documentId: string
  title: string
  host: string
  startsAt: string
  goingBase: number
  category?: { slug: string } | null
  attendees?: { id: number }[]
}

const MAX_EVENTS = 20

const isNotFound = (error: unknown) => (error as { code?: string } | null)?.code === "not-found"

export const toEvent = (entry: StrapiEventEntry, viewerId: number | null): CommunityEvent => ({
  id: entry.documentId,
  title: entry.title,
  host: entry.host,
  at: entry.startsAt,
  going: entry.goingBase + (entry.attendees?.length ?? 0),
  joined: viewerId !== null && (entry.attendees ?? []).some((member) => member.id === viewerId),
  categorySlug: entry.category?.slug ?? "",
})

export class StrapiEventRepository implements EventRepository {
  constructor(private readonly deps: { client: StrapiClient; viewer: () => Promise<Viewer | null>; now?: () => Date }) {}

  async list(options: { categorySlug?: string } = {}): Promise<CommunityEvent[]> {
    const now = this.deps.now?.() ?? new Date()
    const filters: StrapiParams = { startsAt: { $gte: now.toISOString() } }
    if (options.categorySlug) filters.category = { slug: { $eq: options.categorySlug } }
    const [result, viewer] = await Promise.all([
      this.deps.client.get<StrapiList<StrapiEventEntry>>("/api/events", {
        filters,
        populate: { category: { fields: ["slug"] }, attendees: { fields: ["id"] } },
        sort: ["startsAt:asc"],
        pagination: { pageSize: MAX_EVENTS },
      }),
      this.deps.viewer(),
    ])
    return result.data.map((entry) => toEvent(entry, viewer?.id ?? null))
  }

  async toggleRsvp(eventId: string): Promise<boolean | null> {
    const viewer = await this.deps.viewer()
    if (!viewer) throw new AppError("unauthenticated")
    try {
      const result = await this.deps.client.send<{ joined: boolean }>("POST", `/api/events/${eventId}/rsvp`, undefined, { token: viewer.token })
      return result.joined
    } catch (error) {
      if (isNotFound(error)) return null
      throw error
    }
  }
}
