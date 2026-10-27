import { describe, expect, it, vi } from "vitest"

import { createStrapiProfileGateway } from "./strapi-profile.gateway"

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } })

const profile = {
  id: 7,
  username: "alex",
  email: "alex@exemple.fr",
  displayName: "Alex M.",
  bio: "Bonjour",
  interests: ["bourse"],
  avatar: { id: 3, url: "/uploads/avatar_1.png" },
}

const gatewayWith = (respond: (url: string, init: RequestInit) => Response | Promise<Response>) => {
  const fetchImpl = vi.fn(async (url: string | URL | Request, init?: RequestInit) => respond(String(url), init ?? {}))
  return {
    gateway: createStrapiProfileGateway("http://strapi.test", "http://public.test", fetchImpl as unknown as typeof fetch),
    fetchImpl,
  }
}

describe("StrapiProfileGateway", () => {
  describe("update", () => {
    it("sends the profile with the member's token and maps the answer", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, profile))
      const user = await gateway.update("access", { displayName: "Alex M.", bio: "Bonjour", interests: ["bourse"] })
      expect(user).toEqual({
        id: 7,
        username: "alex",
        email: "alex@exemple.fr",
        displayName: "Alex M.",
        bio: "Bonjour",
        interests: ["bourse"],
        avatarUrl: "http://public.test/uploads/avatar_1.png",
      })
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/users/me")
      expect(init?.method).toBe("PUT")
      expect((init?.headers as Record<string, string>).Authorization).toBe("Bearer access")
      expect(JSON.parse(String(init?.body))).toEqual({ displayName: "Alex M.", bio: "Bonjour", interests: ["bourse"] })
    })

    it("maps a profile without avatar", async () => {
      const { gateway } = gatewayWith(() => json(200, { ...profile, avatar: null }))
      expect((await gateway.update("t", { displayName: "Alex", bio: "", interests: [] })).avatarUrl).toBeUndefined()
    })

    it("turns a refusal into a validation error", async () => {
      const { gateway } = gatewayWith(() => json(400, { error: { message: "displayName must be 3 to 24 characters" } }))
      await expect(gateway.update("t", { displayName: "x", bio: "", interests: [] })).rejects.toMatchObject({
        code: "validation",
        fields: { form: "profile.invalid" },
      })
    })

    it("turns an expired session into an unauthenticated error", async () => {
      const { gateway } = gatewayWith(() => json(401, { error: { message: "Missing or invalid credentials" } }))
      await expect(gateway.update("t", { displayName: "Alex", bio: "", interests: [] })).rejects.toMatchObject({
        code: "unauthenticated",
      })
    })

    it("treats a 403 as an unauthenticated error as well", async () => {
      const { gateway } = gatewayWith(() => json(403, { error: { message: "Forbidden" } }))
      await expect(gateway.update("t", { displayName: "Alex", bio: "", interests: [] })).rejects.toMatchObject({
        code: "unauthenticated",
      })
    })

    it("reports an unreachable Strapi as unavailable", async () => {
      const { gateway } = gatewayWith(() => {
        throw new TypeError("fetch failed")
      })
      await expect(gateway.update("t", { displayName: "Alex", bio: "", interests: [] })).rejects.toMatchObject({
        code: "unavailable",
      })
    })
  })

  describe("uploadAvatar", () => {
    it("posts the image as multipart form data and lets fetch set the boundary", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, profile))
      const user = await gateway.uploadAvatar("access", new Blob(["png"], { type: "image/png" }), "avatar.png")
      expect(user.avatarUrl).toBe("http://public.test/uploads/avatar_1.png")
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/users/me/avatar")
      expect(init?.method).toBe("POST")
      const headers = init?.headers as Record<string, string>
      expect(headers.Authorization).toBe("Bearer access")
      expect(headers["Content-Type"]).toBeUndefined()
      const file = (init?.body as FormData).get("files") as File
      expect(file.name).toBe("avatar.png")
      expect(file.type).toBe("image/png")
    })

    it("turns a refused file into a validation error", async () => {
      const { gateway } = gatewayWith(() => json(400, { error: { message: "Avatar must be 2 MB or smaller" } }))
      await expect(gateway.uploadAvatar("t", new Blob(["x"]), "a.png")).rejects.toMatchObject({
        code: "validation",
        fields: { photo: "photo.rejected" },
      })
    })
  })

  describe("removeAvatar", () => {
    it("deletes the avatar and returns the profile without it", async () => {
      const { gateway, fetchImpl } = gatewayWith(() => json(200, { ...profile, avatar: null }))
      const user = await gateway.removeAvatar("access")
      expect(user.avatarUrl).toBeUndefined()
      const [url, init] = fetchImpl.mock.calls[0]
      expect(String(url)).toBe("http://strapi.test/api/users/me/avatar")
      expect(init?.method).toBe("DELETE")
    })
  })
})
