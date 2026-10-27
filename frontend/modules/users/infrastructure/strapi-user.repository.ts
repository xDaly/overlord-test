import type { StrapiClient } from "@/lib/strapi-client"
import type { UserRepository } from "../application/user.repository"
import type { User } from "../domain/user"
import { toUser, type StrapiMember } from "./strapi-member"

const MAX_MEMBERS = 1000

const PUBLIC_FIELDS = [
  "username",
  "displayName",
  "bio",
  "interests",
  "communityRole",
  "avatarColor",
  "subscriber",
  "expertTitle",
  "points",
  "monthPoints",
  "monthKey",
  "streak",
  "badges",
  "stats",
  "createdAt",
]

export class StrapiUserRepository implements UserRepository {
  constructor(private readonly deps: { client: StrapiClient; publicUrl: string; now?: () => Date }) {}

  async list(): Promise<User[]> {
    const members = await this.deps.client.get<StrapiMember[]>("/api/users", {
      fields: PUBLIC_FIELDS,
      populate: { avatar: { fields: ["url"] } },
      start: 0,
      limit: MAX_MEMBERS,
    })
    const now = this.deps.now?.() ?? new Date()
    return members.map((member) => toUser(member, { publicUrl: this.deps.publicUrl, now }))
  }

  async findByUsername(username: string): Promise<User | null> {
    return (await this.list()).find((user) => user.username === username) ?? null
  }
}
