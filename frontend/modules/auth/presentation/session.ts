import { cache } from "react"

import { authGateway } from "../infrastructure/auth.container"
import type { AuthUser } from "../domain/session"
import { readTokens } from "./session-cookies"

export const getAuthUser = cache(async (): Promise<AuthUser | null> => {
  const { accessToken } = await readTokens()
  return accessToken ? authGateway().me(accessToken) : null
})

export async function getAccessToken(): Promise<string | null> {
  const { accessToken } = await readTokens()
  return accessToken ?? null
}
