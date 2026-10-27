import { cookies } from "next/headers"

import {
  ACCESS_COOKIE,
  REFRESH_COOKIE,
  REFRESH_MAX_AGE,
  accessMaxAge,
  type AuthTokens,
} from "../domain/session"

export const SESSION_COOKIE_OPTIONS = {
  httpOnly: true,
  sameSite: "lax",
  secure: process.env.NODE_ENV === "production",
  path: "/",
} as const

export async function readTokens(): Promise<{ accessToken?: string; refreshToken?: string }> {
  const store = await cookies()
  return { accessToken: store.get(ACCESS_COOKIE)?.value, refreshToken: store.get(REFRESH_COOKIE)?.value }
}

export async function writeTokens({ accessToken, refreshToken }: AuthTokens): Promise<void> {
  const store = await cookies()
  store.set(ACCESS_COOKIE, accessToken, { ...SESSION_COOKIE_OPTIONS, maxAge: accessMaxAge(accessToken, Date.now()) })
  store.set(REFRESH_COOKIE, refreshToken, { ...SESSION_COOKIE_OPTIONS, maxAge: REFRESH_MAX_AGE })
}

export async function clearTokens(): Promise<void> {
  const store = await cookies()
  store.delete(ACCESS_COOKIE)
  store.delete(REFRESH_COOKIE)
}
