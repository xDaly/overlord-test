import type { AuthUser } from "../domain/session"

export type StrapiUser = {
  id: number
  username: string
  email: string
  displayName?: string | null
  bio?: string | null
  interests?: string[] | null
  avatar?: { url: string } | null
}

const absolute = (publicUrl: string, url: string) => (/^https?:\/\//.test(url) ? url : `${publicUrl}${url}`)

export const toAuthUser = (user: StrapiUser, publicUrl: string): AuthUser => ({
  id: user.id,
  username: user.username,
  email: user.email,
  displayName: user.displayName || user.username,
  bio: user.bio ?? "",
  interests: user.interests ?? [],
  avatarUrl: user.avatar?.url ? absolute(publicUrl, user.avatar.url) : undefined,
})
