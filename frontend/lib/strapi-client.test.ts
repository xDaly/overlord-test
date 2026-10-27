import { describe, expect, it, vi } from "vitest"

import { createStrapiClient, type StrapiList } from "./strapi-client"

const json = (status: number, body: unknown) =>
  new Response(JSON.stringify(body), { status, headers: { "Content-Type": "application/json" } })

const clientWith = (respond: (url: string, init: RequestInit) => Response | Promise<Response>) => {
  const fetchImpl = vi.fn(async (url: string | URL | Request, init?: RequestInit) => respond(String(url), init ?? {}))
  return {
    client: createStrapiClient({ baseUrl: "http://strapi.test", apiToken: "server-token", fetchImpl: fetchImpl as unknown as typeof fetch }),
    fetchImpl,
  }
}

describe("StrapiClient", () => {
  describe("get", () => {
    it("reads with the server API token and serialises the query", async () => {
      const { client, fetchImpl } = clientWith(() => json(200, { data: [{ id: 1 }], meta: { pagination: { total: 1 } } }))
      const result = await client.get<StrapiList<{ id: number }>>("/api/discussions", { filters: { slug: { $eq: "a" } }, sort: ["createdAt:desc"] })
      expect(result.data).toEqual([{ id: 1 }])
      expect(result.meta?.pagination?.total).toBe(1)
      const [url, init] = fetchImpl.mock.calls[0]
      expect(decodeURIComponent(String(url))).toBe("http://strapi.test/api/discussions?filters[slug][$eq]=a&sort[0]=createdAt:desc")
      expect((init?.headers as Record<string, string>).Authorization).toBe("Bearer server-token")
      expect(init?.method).toBe("GET")
    })

    it("reads in the name of a signed-in member when given their token", async () => {
      const { client, fetchImpl } = clientWith(() => json(200, { data: [] }))
      await client.get("/api/discussions", {}, { token: "member-token" })
      expect((fetchImpl.mock.calls[0][1]?.headers as Record<string, string>).Authorization).toBe("Bearer member-token")
    })

    it("omits the question mark when there is no query", async () => {
      const { client, fetchImpl } = clientWith(() => json(200, { data: [] }))
      await client.get("/api/categories")
      expect(String(fetchImpl.mock.calls[0][0])).toBe("http://strapi.test/api/categories")
    })
  })

  describe("send", () => {
    it("posts JSON with the member's token and returns the body", async () => {
      const { client, fetchImpl } = clientWith(() => json(201, { data: { id: 5 } }))
      const result = await client.send<{ data: { id: number } }>("POST", "/api/replies", { data: { content: "x" } }, { token: "member-token" })
      expect(result.data.id).toBe(5)
      const [, init] = fetchImpl.mock.calls[0]
      expect(init?.method).toBe("POST")
      expect(JSON.parse(String(init?.body))).toEqual({ data: { content: "x" } })
      expect((init?.headers as Record<string, string>).Authorization).toBe("Bearer member-token")
    })

    it("sends without a body", async () => {
      const { client, fetchImpl } = clientWith(() => json(200, { liked: true }))
      await client.send("POST", "/api/discussions/a/useful", undefined, { token: "t" })
      expect(fetchImpl.mock.calls[0][1]?.body).toBeUndefined()
    })
  })

  describe("errors", () => {
    it.each([
      [401, "unauthenticated"],
      [403, "forbidden"],
      [404, "not-found"],
      [400, "validation"],
      [500, "unavailable"],
    ])("turns a %i answer into a %s error", async (status, code) => {
      const { client } = clientWith(() => json(status, { error: { message: "refus" } }))
      await expect(client.get("/api/x")).rejects.toMatchObject({ code })
    })

    it("keeps Strapi's message on a validation error", async () => {
      const { client } = clientWith(() => json(400, { error: { message: "title must be 10 to 160 characters" } }))
      await expect(client.send("POST", "/api/discussions", {})).rejects.toMatchObject({
        fields: { form: "title must be 10 to 160 characters" },
      })
    })

    it("reports an unreachable Strapi as unavailable", async () => {
      const { client } = clientWith(() => {
        throw new TypeError("fetch failed")
      })
      await expect(client.get("/api/x")).rejects.toMatchObject({ code: "unavailable" })
    })
  })
})
