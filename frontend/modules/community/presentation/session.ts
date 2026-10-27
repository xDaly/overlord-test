import { cookies } from "next/headers"

import { getAuthUser } from "@/modules/auth/presentation/session"
import type { User } from "@/modules/users/domain/user"
import { unknownUser } from "@/modules/users/infrastructure/strapi-member"
import { community } from "../community.container"

export const STAFF_COOKIE = "lr-staff"
export const DENSITY_COOKIE = "lr-density"

export type Density = "comfy" | "compact"

export async function getSessionUser(): Promise<User | null> {
  const account = await getAuthUser()
  if (!account) return null
  const member = await community().users.findByUsername(account.username)
  return member ?? { ...unknownUser(account.username), name: account.displayName, bio: account.bio, interests: account.interests, photo: account.avatarUrl }
}

export async function getViewFlags(): Promise<{ staff: boolean; density: Density }> {
  const store = await cookies()
  return {
    staff: store.get(STAFF_COOKIE)?.value === "1",
    density: store.get(DENSITY_COOKIE)?.value === "compact" ? "compact" : "comfy",
  }
}
