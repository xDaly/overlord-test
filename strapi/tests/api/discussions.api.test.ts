import { afterAll, beforeAll, describe, expect, it } from "vitest"
import { DEMO_EMAIL_DOMAIN, call, categoryId, draft, loginDemoMember, type Member } from "./support"

let camille: Member
let vincent: Member
let category: string
const created: { token: string; documentId: string }[] = []

const publish = async (member: Member, data: Record<string, unknown>) => {
  const result = await call("POST", "/api/discussions", { token: member.jwt, body: { data } })
  if (result.status === 201) created.push({ token: member.jwt, documentId: result.json.data.documentId })
  return result
}

beforeAll(async () => {
  camille = await loginDemoMember("Camille_B")
  vincent = await loginDemoMember("Vincent_ETF")
  category = await categoryId(camille.jwt, "bourse")
})

afterAll(async () => {
  for (const { token, documentId } of created) await call("DELETE", `/api/discussions/${documentId}`, { token })
})

describe("validation d'une discussion (côté Strapi)", () => {
  it("refuse un titre de moins de 10 caractères", async () => {
    const result = await publish(camille, draft(category, { title: "court" }))
    expect(result.status).toBe(400)
  })

  it("accepte un titre de exactement 10 caractères", async () => {
    const result = await publish(camille, draft(category, { title: "1234567890" }))
    expect(result.status).toBe(201)
  })

  it("refuse un contenu vide ou ne contenant que des espaces", async () => {
    expect((await publish(camille, draft(category, { content: " " }))).status).toBe(400)
    expect((await publish(camille, draft(category, { content: undefined }))).status).toBe(400)
  })

  it("refuse un type inconnu", async () => {
    expect((await publish(camille, draft(category, { type: "article" }))).status).toBe(400)
  })

  it("refuse une discussion sans catégorie ou avec une catégorie inexistante", async () => {
    expect((await publish(camille, draft(category, { category: undefined }))).status).toBe(400)
    expect((await publish(camille, draft(category, { category: "inexistante" }))).status).toBe(400)
  })

  it("explique l'erreur dans la réponse (message exploitable par le formulaire)", async () => {
    const result = await publish(camille, draft(category, { title: "court" }))
    expect(JSON.stringify(result.json.error)).toMatch(/titre|title/i)
  })

  it("refuse un sondage de moins de deux options et nettoie les options valides", async () => {
    const base = { title: "Votre placement favori cette année ?", content: "", type: "poll", category }
    expect((await publish(camille, { ...base, pollOptions: ["Seule"] })).status).toBe(400)
    const ok = await publish(camille, { ...base, pollOptions: ["Actions", "Obligations", ""] })
    expect(ok.status).toBe(201)
    expect(ok.json.data.pollOptions).toEqual(["Actions", "Obligations"])
    expect(ok.json.data.pollVotes.counts).toEqual([0, 0])
  })
})

describe("publication par un utilisateur non authentifié", () => {
  it("refuse la création sans jeton", async () => {
    const result = await call("POST", "/api/discussions", { body: { data: draft(category) } })
    expect([401, 403]).toContain(result.status)
  })

  it("refuse la création avec un jeton invalide", async () => {
    const result = await call("POST", "/api/discussions", { token: "jeton.invalide.xyz", body: { data: draft(category) } })
    expect([401, 403]).toContain(result.status)
  })

  it("refuse aussi la lecture, la modification et la suppression", async () => {
    expect([401, 403]).toContain((await call("GET", "/api/discussions")).status)
    expect([401, 403]).toContain((await call("PUT", "/api/discussions/abc", { body: { data: { title: "Un titre modifié" } } })).status)
    expect([401, 403]).toContain((await call("DELETE", "/api/discussions/abc")).status)
  })
})

describe("usurpation d'auteur", () => {
  it("attribue la discussion au membre connecté, quel que soit l'auteur envoyé", async () => {
    const result = await publish(camille, draft(category, { author: vincent.id }))
    expect(result.status).toBe(201)
    expect(result.json.data.author.username).toBe(camille.username)
  })

  it("ignore les champs réservés (slug, épinglage, vues, mise en avant, compteur d'utile)", async () => {
    const result = await publish(camille, draft(category, { slug: "force", pinned: true, views: 99999, featured: "poll", usefulBase: 500 }))
    const data = result.json.data
    expect(data.slug).not.toBe("force")
    expect(data).toMatchObject({ pinned: false, views: 0, usefulBase: 0 })
    expect(data.featured).toBeFalsy()
  })

  it("interdit à un autre membre de modifier ou supprimer la discussion", async () => {
    const own = await publish(camille, draft(category, { title: "Une discussion à protéger des autres" }))
    const documentId = own.json.data.documentId
    expect((await call("PUT", `/api/discussions/${documentId}`, { token: vincent.jwt, body: { data: { title: "Titre détourné par un autre" } } })).status).toBe(403)
    expect((await call("DELETE", `/api/discussions/${documentId}`, { token: vincent.jwt })).status).toBe(403)
    const check = await call("GET", `/api/discussions/${documentId}`, { token: camille.jwt })
    expect(check.json.data.title).toBe("Une discussion à protéger des autres")
  })

  it("laisse l'auteur modifier son titre sans pouvoir changer l'auteur", async () => {
    const own = await publish(camille, draft(category, { title: "Titre initial de la discussion" }))
    const documentId = own.json.data.documentId
    const update = await call("PUT", `/api/discussions/${documentId}`, { token: camille.jwt, body: { data: { title: "Titre corrigé par son auteur", author: vincent.id } } })
    expect(update.status).toBe(200)
    const stored = await call("GET", `/api/discussions/${documentId}?populate[author][fields][0]=username`, { token: vincent.jwt })
    expect(stored.json.data.title).toBe("Titre corrigé par son auteur")
    expect(stored.json.data.author.username).toBe(camille.username)
  })
})

describe("création réussie", () => {
  it("génère une URL propre depuis le titre et la rend unique en cas de doublon", async () => {
    const title = "Quel courtier choisir pour débuter en bourse ?"
    const first = await publish(camille, draft(category, { title }))
    const second = await publish(vincent, draft(category, { title }))
    expect(first.status).toBe(201)
    expect(first.json.data.slug).toBe("quel-courtier-choisir-pour-debuter-en-bourse")
    expect(second.json.data.slug).toBe("quel-courtier-choisir-pour-debuter-en-bourse-2")
  })

  it("renvoie la catégorie et l'auteur, sans jamais exposer d'adresse e-mail", async () => {
    const result = await publish(camille, draft(category))
    expect(result.json.data.category.slug).toBe("bourse")
    expect(JSON.stringify(result.json)).not.toContain(DEMO_EMAIL_DOMAIN)
  })
})

describe("affichage des discussions", () => {
  const list = (query: string) => call("GET", `/api/discussions?${query}`, { token: vincent.jwt })

  it("pagine côté Strapi", async () => {
    const result = await list("pagination[page]=1&pagination[pageSize]=5&sort[0]=createdAt:desc")
    expect(result.status).toBe(200)
    expect(result.json.data).toHaveLength(5)
    expect(result.json.meta.pagination).toMatchObject({ page: 1, pageSize: 5 })
    expect(result.json.meta.pagination.total).toBeGreaterThanOrEqual(20)
    expect(result.json.meta.pagination.pageCount).toBeGreaterThanOrEqual(4)
  })

  it("trie par date de publication, la plus récente d'abord, et inversement", async () => {
    const newest = (await list("pagination[pageSize]=10&sort[0]=createdAt:desc")).json.data.map((d: any) => d.createdAt)
    const oldest = (await list("pagination[pageSize]=10&sort[0]=createdAt:asc")).json.data.map((d: any) => d.createdAt)
    expect(newest).toEqual([...newest].sort().reverse())
    expect(oldest).toEqual([...oldest].sort())
  })

  it("filtre par catégorie", async () => {
    const all = await list("fields[0]=title&pagination[pageSize]=1")
    const bourse = await list("filters[category][slug][$eq]=bourse&populate[category][fields][0]=slug&pagination[pageSize]=100")
    expect(bourse.json.data.length).toBeGreaterThan(0)
    expect(bourse.json.meta.pagination.total).toBeLessThan(all.json.meta.pagination.total)
    expect(bourse.json.data.every((d: any) => d.category.slug === "bourse")).toBe(true)
  })

  it("renvoie auteur, catégorie et réponses en une seule requête", async () => {
    const result = await list("pagination[pageSize]=20&populate[author][fields][0]=username&populate[category][fields][0]=slug&populate[replies][fields][0]=createdAt")
    expect(result.json.data.every((d: any) => d.author?.username && d.category?.slug && Array.isArray(d.replies))).toBe(true)
    expect(result.json.data.some((d: any) => d.replies.length > 0)).toBe(true)
  })

  it("recherche par texte dans le titre ou le contenu", async () => {
    const result = await list("filters[$or][0][title][$containsi]=pea&filters[$or][1][content][$containsi]=pea&fields[0]=title")
    expect(result.json.data.length).toBeGreaterThan(0)
  })

  it("isole les discussions sans réponse", async () => {
    const result = await list("filters[replies][id][$null]=true&populate[replies][fields][0]=id&pagination[pageSize]=100")
    expect(result.json.data.length).toBeGreaterThan(0)
    expect(result.json.data.every((d: any) => d.replies.length === 0)).toBe(true)
  })

  it("retrouve une discussion par son URL (slug) avec ses réponses et leurs auteurs", async () => {
    const result = await list("filters[slug][$eq]=ouvrir-un-pea-avec-5-000-par-ou-commencer&populate[replies][populate][author][fields][0]=username")
    expect(result.json.data).toHaveLength(1)
    expect(result.json.data[0].replies.length).toBeGreaterThan(0)
    expect(result.json.data[0].replies[0].author.username).toBeTruthy()
  })

  it("n'expose aucune adresse e-mail, même avec un populate gourmand", async () => {
    const result = await list("pagination[pageSize]=20&populate[author]=true&populate[usefulBy]=true&populate[followedBy]=true&populate[replies][populate][author]=true")
    expect(result.status).toBe(200)
    expect(JSON.stringify(result.json)).not.toContain(DEMO_EMAIL_DOMAIN)
  })
})

describe("suppression", () => {
  it("supprime aussi les réponses de la discussion", async () => {
    const own = await publish(camille, draft(category, { title: "Discussion supprimée avec ses réponses" }))
    const documentId = own.json.data.documentId
    await call("POST", "/api/replies", { token: vincent.jwt, body: { data: { content: "Réponse orpheline si rien n'est fait", discussion: documentId } } })
    const countReplies = async () =>
      (await call("GET", "/api/replies?filters[content][$eq]=Réponse orpheline si rien n'est fait", { token: camille.jwt })).json.data.length
    expect(await countReplies()).toBe(1)
    expect((await call("DELETE", `/api/discussions/${documentId}`, { token: camille.jwt })).status).toBe(204)
    expect(await countReplies()).toBe(0)
  })
})
