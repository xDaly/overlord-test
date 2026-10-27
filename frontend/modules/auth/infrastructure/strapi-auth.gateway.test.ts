import { describe, expect, it, vi } from "vitest"

import { createStrapiAuthGateway } from "./strapi-auth.gateway"

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } })

const strapiUser = { id: 7, username: "alex", email: "alex@exemple.fr", displayName: "Alex M." }

const gatewayWith = (respond: (url: string, init: RequestInit) => Response | Promise<Response>) => {
  const fetchImpl = vi.fn(async (url: string | URL | Request, init?: RequestInit) => respond(String(url), init ?? {}))
  return { gateway: createStrapiAuthGateway("http://strapi.test", fetchImpl as unknown as typeof fetch), fetchImpl }
}

describe("StrapiAuthGateway", () => {
  describe("login", () => {
    it("posts the credentials and maps the session", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, { jwt: "access", refreshToken: "refresh", user: strapiUser }))
      const session = await gateway.login("alex@exemple.fr", "secret")
      expect(session).toEqual({
        user: { id: 7, username: "alex", email: "alex@exemple.fr", displayName: "Alex M.", bio: "", interests: [] },
        tokens: { accessToken: "access", refreshToken: "refresh" },
      })
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/auth/local")
      expect(init?.method).toBe("POST")
      expect(JSON.parse(String(init?.body))).toEqual({ identifier: "alex@exemple.fr", password: "secret" })
    })

    it("falls back to the username when there is no display name", async () => {
      const { gateway } = gatewayWith(() =>
        json(200, { jwt: "a", refreshToken: "r", user: { ...strapiUser, displayName: null } })
      )
      expect((await gateway.login("x", "y")).user.displayName).toBe("alex")
    })

    it("turns a rejected login into an unauthenticated error", async () => {
      const { gateway } = gatewayWith(() => json(400, { error: { name: "ValidationError", message: "Invalid identifier or password" } }))
      await expect(gateway.login("alex@exemple.fr", "bad")).rejects.toMatchObject({
        code: "unauthenticated",
        fields: { form: "credentials.invalid" },
      })
    })

    it("reports an unreachable Strapi as unavailable", async () => {
      const { gateway } = gatewayWith(() => {
        throw new TypeError("fetch failed")
      })
      await expect(gateway.login("a", "b")).rejects.toMatchObject({ code: "unavailable" })
    })

    it("reports a server error as unavailable", async () => {
      const { gateway } = gatewayWith(() => json(500, { error: { message: "boom" } }))
      await expect(gateway.login("a", "b")).rejects.toMatchObject({ code: "unavailable" })
    })
  })

  describe("register", () => {
    const input = { username: "alex", email: "alex@exemple.fr", password: "motdepasse1", displayName: "alex" }

    it("posts the account including the display name", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, { jwt: "a", refreshToken: "r", user: strapiUser }))
      await gateway.register(input)
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/auth/local/register")
      expect(JSON.parse(String(init?.body))).toEqual(input)
    })

    it("reports a taken e-mail or username", async () => {
      const { gateway } = gatewayWith(() => json(400, { error: { name: "ApplicationError", message: "Email or Username are already taken" } }))
      await expect(gateway.register(input)).rejects.toMatchObject({ code: "validation", fields: { form: "account.taken" } })
    })

    it("reports any other refusal as an invalid registration", async () => {
      const { gateway } = gatewayWith(() => json(400, { error: { name: "ValidationError", message: "Invalid parameters: role" } }))
      await expect(gateway.register(input)).rejects.toMatchObject({ code: "validation", fields: { form: "register.invalid" } })
    })
  })

  describe("me", () => {
    it("sends the access token and maps the user", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, strapiUser))
      await expect(gateway.me("access")).resolves.toEqual({
        id: 7,
        username: "alex",
        email: "alex@exemple.fr",
        displayName: "Alex M.",
        bio: "",
        interests: [],
      })
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/users/me")
      expect((init?.headers as Record<string, string>).Authorization).toBe("Bearer access")
    })

    it("returns null for an invalid or expired token", async () => {
      const { gateway } = gatewayWith(() => json(401, { error: { message: "Invalid token" } }))
      await expect(gateway.me("expired")).resolves.toBeNull()
    })

    it("returns null when Strapi is unreachable, so the visitor sees the signed-out site", async () => {
      const { gateway } = gatewayWith(() => {
        throw new TypeError("fetch failed")
      })
      await expect(gateway.me("access")).resolves.toBeNull()
    })
  })

  describe("refresh", () => {
    it("exchanges the refresh token for new tokens", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, { jwt: "new-access", refreshToken: "new-refresh" }))
      await expect(gateway.refresh("old-refresh")).resolves.toEqual({ accessToken: "new-access", refreshToken: "new-refresh" })
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/auth/refresh")
      expect(JSON.parse(String(init?.body))).toEqual({ refreshToken: "old-refresh" })
    })

    it("rejects a revoked refresh token", async () => {
      const { gateway } = gatewayWith(() => json(401, { error: { message: "Invalid refresh token" } }))
      await expect(gateway.refresh("revoked")).rejects.toMatchObject({ code: "unauthenticated" })
    })
  })

  describe("logout", () => {
    it("revokes the session on Strapi", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, { ok: true }))
      await gateway.logout({ accessToken: "access", refreshToken: "refresh" })
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/auth/logout")
      expect((init?.headers as Record<string, string>).Authorization).toBe("Bearer access")
      expect(JSON.parse(String(init?.body))).toEqual({ refreshToken: "refresh" })
    })

    it("never fails the sign-out when Strapi is unreachable", async () => {
      const { gateway } = gatewayWith(() => {
        throw new TypeError("fetch failed")
      })
      await expect(gateway.logout({ accessToken: "a", refreshToken: "r" })).resolves.toBeUndefined()
    })
  })
})
