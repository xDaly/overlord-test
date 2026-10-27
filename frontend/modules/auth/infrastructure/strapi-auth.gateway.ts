import { API_ROUTES } from "@/lib/api-routes"
import { AppError } from "@/lib/errors"
import { strapiSend } from "@/lib/strapi-send"
import type { AuthGateway } from "../application/auth.gateway"
import type { Effect } from "@/modules/users/domain/gamification"
import type { AuthSession, AuthTokens } from "../domain/session"
import { toAuthUser, type StrapiUser } from "./strapi-user"

type StrapiAuthBody = { jwt: string; refreshToken: string; user: StrapiUser; effects?: Effect[] }

const errorMessage = async (response: Response): Promise<string> => {
  try {
    const body = (await response.json()) as { error?: { message?: string } }
    return body.error?.message ?? ""
  } catch {
    return ""
  }
}

export function createStrapiAuthGateway(
  baseUrl: string,
  fetchImpl: typeof fetch = fetch,
  publicUrl: string = baseUrl
): AuthGateway {
  const send = (path: string, request: Parameters<typeof strapiSend>[3]) => strapiSend(fetchImpl, baseUrl, path, request)

  const toSession = (body: StrapiAuthBody): AuthSession => ({
    user: toAuthUser(body.user, publicUrl),
    tokens: { accessToken: body.jwt, refreshToken: body.refreshToken },
    ...(body.effects ? { welcome: body.effects } : {}),
  })

  const unavailable = (response: Response) =>
    new AppError("unavailable", response.status === 429 ? { form: "rate.limited" } : {})

  return {
    async login(identifier, password) {
      const response = await send(API_ROUTES.auth.login, { method: "POST", json: { identifier, password } })
      if (response.ok) return toSession((await response.json()) as StrapiAuthBody)
      if (response.status === 400 || response.status === 401) {
        throw new AppError("unauthenticated", { form: "credentials.invalid" })
      }
      throw unavailable(response)
    },

    async register(account) {
      const response = await send(API_ROUTES.auth.register, { method: "POST", json: account })
      if (response.ok) return toSession((await response.json()) as StrapiAuthBody)
      if (response.status === 400) {
        const message = await errorMessage(response)
        throw new AppError("validation", { form: /already taken/i.test(message) ? "account.taken" : "register.invalid" })
      }
      throw unavailable(response)
    },

    async refresh(refreshToken): Promise<AuthTokens> {
      const response = await send(API_ROUTES.auth.refresh, { method: "POST", json: { refreshToken } })
      if (response.ok) {
        const body = (await response.json()) as { jwt: string; refreshToken: string }
        return { accessToken: body.jwt, refreshToken: body.refreshToken }
      }
      if (response.status === 400 || response.status === 401) throw new AppError("unauthenticated")
      throw unavailable(response)
    },

    async me(accessToken) {
      try {
        const response = await send(API_ROUTES.users.me, {
          method: "GET",
          headers: { Authorization: `Bearer ${accessToken}` },
        })
        return response.ok ? toAuthUser((await response.json()) as StrapiUser, publicUrl) : null
      } catch {
        return null
      }
    },

    async logout({ accessToken, refreshToken }) {
      try {
        await send(API_ROUTES.auth.logout, {
          method: "POST",
          headers: { Authorization: `Bearer ${accessToken}` },
          json: { refreshToken },
        })
      } catch {
      }
    },
  }
}
