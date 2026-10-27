import { vi } from "vitest"

import { unknownUser } from "@/modules/users/infrastructure/strapi-member"
import type { User } from "@/modules/users/domain/user"
import type { CommunityDeps } from "../application/deps"

export const member = (username: string, patch: Partial<User> = {}): User => ({ ...unknownUser(username), ...patch })

export function stubDeps(): { [K in keyof CommunityDeps]: { [M in keyof CommunityDeps[K]]: ReturnType<typeof vi.fn> } } {
  const repository = <T extends string>(methods: T[]) =>
    Object.fromEntries(methods.map((method) => [method, vi.fn()])) as Record<T, ReturnType<typeof vi.fn>>
  return {
    discussions: repository([
      "list",
      "countUnanswered",
      "questionStats",
      "findById",
      "search",
      "listByAuthor",
      "listRepliesBy",
      "featured",
      "similarCandidates",
      "create",
      "addReply",
      "toggleLike",
      "toggleFollow",
      "vote",
      "toggleSolution",
      "toggleVerified",
    ]),
    blogs: repository(["list", "findById", "listByAuthor", "create", "addComment", "toggleLike"]),
    events: repository(["list", "toggleRsvp"]),
    users: repository(["list", "findByUsername"]),
    notifications: repository(["list", "markRead", "markAllRead"]),
  }
}

export const asDeps = (stubs: ReturnType<typeof stubDeps>) => stubs as unknown as CommunityDeps
