import type { Effect } from "@/modules/users/domain/gamification"

export type AuthUser = {
  id: number
  username: string
  email: string
  displayName: string
  bio: string
  interests: string[]
  avatarUrl?: string
}

export type AuthTokens = { accessToken: string; refreshToken: string }

export type AuthSession = { user: AuthUser; tokens: AuthTokens; welcome?: Effect[] }

export const ACCESS_COOKIE = "lr-access"
export const REFRESH_COOKIE = "lr-refresh"

export const REFRESH_MAX_AGE = 30 * 24 * 60 * 60

export const REFRESH_SKEW_MS = 30_000

const DEFAULT_ACCESS_MAX_AGE = 10 * 60

export function jwtExpiry(token: string): number | null {
  const payload = token.split(".")[1]
  if (!payload) return null
  try {
    const base64 = payload.replace(/-/g, "+").replace(/_/g, "/")
    const claims: unknown = JSON.parse(atob(base64))
    const exp = (claims as { exp?: unknown } | null)?.exp
    return typeof exp === "number" ? exp : null
  } catch {
    return null
  }
}

export function needsRefresh(accessToken: string | undefined, nowMs: number, skewMs = REFRESH_SKEW_MS): boolean {
  if (!accessToken) return true
  const exp = jwtExpiry(accessToken)
  return exp === null || exp * 1000 - nowMs <= skewMs
}

export function accessMaxAge(token: string, nowMs: number, fallbackSeconds = DEFAULT_ACCESS_MAX_AGE): number {
  const exp = jwtExpiry(token)
  return exp === null ? fallbackSeconds : Math.max(1, Math.floor(exp - nowMs / 1000))
}
