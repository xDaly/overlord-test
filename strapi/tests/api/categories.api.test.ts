import { afterAll, beforeAll, describe, expect, it } from "vitest"
import { call, categoryId, loginDemoMember, type Member } from "./support"

let camille: Member
const created: string[] = []

beforeAll(async () => {
  camille = await loginDemoMember("Camille_B")
})

afterAll(async () => {
  for (const documentId of created) await call("DELETE", `/api/discussions/${documentId}`, { token: camille.jwt })
})

const bourse = async () => {
  const result = await call("GET", "/api/categories?filters[slug][$eq]=bourse", { token: camille.jwt })
  return result.json.data[0]
}

describe("espaces (catégories)", () => {
  it("refuse la lecture anonyme", async () => {
    expect((await call("GET", "/api/categories")).status).toBe(403)
  })

  it("renvoie la présentation de chaque espace saisie dans Strapi", async () => {
    const result = await call("GET", "/api/categories?sort=id:asc", { token: camille.jwt })
    expect(result.status).toBe(200)
    expect(result.json.data.length).toBeGreaterThan(0)
    for (const entry of result.json.data) {
      expect(entry).toMatchObject({ slug: expect.any(String), name: expect.any(String), icon: expect.any(String) })
      expect(entry.color).toMatch(/^#[0-9a-f]{6}$/i)
    }
  })

  it("compte les discussions et les réponses de l'espace, en liste comme en fiche", async () => {
    const entry = await bourse()
    const discussions = await call("GET", "/api/discussions?filters[category][slug][$eq]=bourse&pagination[withCount]=true", { token: camille.jwt })
    expect(entry.discussionsCount).toBe(discussions.json.meta.pagination.total)
    expect(entry.repliesCount).toEqual(expect.any(Number))

    const single = await call("GET", `/api/categories/${entry.documentId}`, { token: camille.jwt })
    expect(single.json.data).toMatchObject({ discussionsCount: entry.discussionsCount, repliesCount: entry.repliesCount })
  })

  it("tient les compteurs à jour quand une discussion ou une réponse est publiée", async () => {
    const before = await bourse()
    const discussion = await call("POST", "/api/discussions", {
      token: camille.jwt,
      body: { data: { title: "Compteurs d'un espace : test", content: "Contenu", type: "discussion", category: await categoryId(camille.jwt, "bourse") } },
    })
    created.push(discussion.json.data.documentId)
    await call("POST", "/api/replies", { token: camille.jwt, body: { data: { content: "Réponse", discussion: discussion.json.data.documentId } } })

    const after = await bourse()
    expect(after.discussionsCount).toBe(before.discussionsCount + 1)
    expect(after.repliesCount).toBe(before.repliesCount + 1)
  })
})
