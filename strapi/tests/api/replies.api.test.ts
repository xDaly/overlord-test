import { afterAll, beforeAll, describe, expect, it } from "vitest"
import { DEMO_EMAIL_DOMAIN, call, categoryId, draft, loginDemoMember, type Member } from "./support"

let camille: Member
let vincent: Member
let discussion: string

const reply = (member: Member, data: Record<string, unknown>) => call("POST", "/api/replies", { token: member.jwt, body: { data } })

beforeAll(async () => {
  camille = await loginDemoMember("Camille_B")
  vincent = await loginDemoMember("Vincent_ETF")
  const created = await call("POST", "/api/discussions", {
    token: camille.jwt,
    body: { data: draft(await categoryId(camille.jwt, "bourse"), { title: "Fil de test pour les réponses" }) },
  })
  discussion = created.json.data.documentId
})

afterAll(async () => {
  if (discussion) await call("DELETE", `/api/discussions/${discussion}`, { token: camille.jwt })
})

describe("publication d'une réponse", () => {
  it("enregistre la réponse et la rattache à la discussion", async () => {
    const result = await reply(vincent, { content: "Comparez les frais de courtage.", discussion })
    expect(result.status).toBe(201)
    expect(result.json.data.content).toBe("Comparez les frais de courtage.")
    const thread = await call("GET", `/api/discussions/${discussion}?populate[replies][populate][author][fields][0]=username`, { token: camille.jwt })
    expect(thread.json.data.replies.map((r: any) => r.content)).toContain("Comparez les frais de courtage.")
  })

  it("refuse une réponse vide ou ne contenant que des espaces", async () => {
    expect((await reply(vincent, { content: "   ", discussion })).status).toBe(400)
    expect((await reply(vincent, { discussion })).status).toBe(400)
  })

  it("refuse une réponse sans discussion ou vers une discussion inexistante", async () => {
    expect((await reply(vincent, { content: "Une réponse dans le vide" })).status).toBe(400)
    expect((await reply(vincent, { content: "Une réponse dans le vide", discussion: "inexistante" })).status).toBe(400)
  })

  it("refuse la publication d'un visiteur non authentifié", async () => {
    const result = await call("POST", "/api/replies", { body: { data: { content: "Réponse anonyme", discussion } } })
    expect([401, 403]).toContain(result.status)
  })
})

describe("usurpation d'auteur", () => {
  it("attribue la réponse au membre connecté, quel que soit l'auteur envoyé", async () => {
    const result = await reply(vincent, { content: "Je ne suis pas Camille.", discussion, author: camille.id })
    expect(result.status).toBe(201)
    expect(result.json.data.author.username).toBe(vincent.username)
  })

  it("ignore les drapeaux réservés (meilleure réponse, vérifiée, compteur d'utile)", async () => {
    const result = await reply(vincent, { content: "Je me déclare meilleure réponse.", discussion, isBestAnswer: true, verified: true, usefulBase: 99 })
    expect(result.json.data).toMatchObject({ isBestAnswer: false, verified: false, usefulBase: 0 })
  })

  it("interdit à un autre membre de modifier ou supprimer une réponse", async () => {
    const mine = await reply(vincent, { content: "Ma réponse protégée.", discussion })
    const documentId = mine.json.data.documentId
    expect((await call("PUT", `/api/replies/${documentId}`, { token: camille.jwt, body: { data: { content: "Texte détourné" } } })).status).toBe(403)
    expect((await call("DELETE", `/api/replies/${documentId}`, { token: camille.jwt })).status).toBe(403)
  })

  it("laisse l'auteur modifier le texte sans pouvoir changer l'auteur", async () => {
    const mine = await reply(vincent, { content: "Texte initial de la réponse.", discussion })
    const update = await call("PUT", `/api/replies/${mine.json.data.documentId}`, {
      token: vincent.jwt,
      body: { data: { content: "Texte corrigé par son auteur.", author: camille.id } },
    })
    expect(update.status).toBe(200)
    const stored = await call("GET", `/api/replies/${mine.json.data.documentId}?populate[author][fields][0]=username`, { token: camille.jwt })
    expect(stored.json.data.content).toBe("Texte corrigé par son auteur.")
    expect(stored.json.data.author.username).toBe(vincent.username)
  })

  it("refuse de remplacer le texte par du vide", async () => {
    const mine = await reply(vincent, { content: "Texte à ne pas effacer.", discussion })
    const update = await call("PUT", `/api/replies/${mine.json.data.documentId}`, { token: vincent.jwt, body: { data: { content: "  " } } })
    expect(update.status).toBe(400)
  })

  it("n'expose aucune adresse e-mail dans les réponses", async () => {
    const result = await call("GET", "/api/replies?populate[author]=true&populate[usefulBy]=true&pagination[pageSize]=100", { token: vincent.jwt })
    expect(result.status).toBe(200)
    expect(JSON.stringify(result.json)).not.toContain(DEMO_EMAIL_DOMAIN)
  })
})

describe("meilleure réponse", () => {
  it("n'est choisie que par l'auteur de la discussion", async () => {
    const answer = await reply(vincent, { content: "Candidate à la meilleure réponse.", discussion })
    const response = await call("PUT", `/api/replies/${answer.json.data.documentId}`, { token: vincent.jwt, body: { data: { isBestAnswer: true } } })
    expect(response.status).toBe(403)
  })

  it("remplace la précédente quand l'auteur en choisit une autre", async () => {
    const first = (await reply(vincent, { content: "Première candidate.", discussion })).json.data.documentId
    const second = (await reply(vincent, { content: "Seconde candidate.", discussion })).json.data.documentId
    const choose = (documentId: string) => call("PUT", `/api/replies/${documentId}`, { token: camille.jwt, body: { data: { isBestAnswer: true } } })
    expect((await choose(first)).json.data.isBestAnswer).toBe(true)
    await choose(second)
    const thread = await call("GET", `/api/discussions/${discussion}?populate[replies][fields][0]=isBestAnswer`, { token: camille.jwt })
    expect(thread.json.data.replies.filter((r: any) => r.isBestAnswer)).toHaveLength(1)
    const best = await call("GET", `/api/replies/${second}`, { token: camille.jwt })
    expect(best.json.data.isBestAnswer).toBe(true)
  })
})

describe("vote « Utile »", () => {
  it("bascule le vote d'un membre et refuse les visiteurs", async () => {
    const answer = (await reply(vincent, { content: "Une réponse utile.", discussion })).json.data.documentId
    const on = await call("POST", `/api/replies/${answer}/useful`, { token: camille.jwt })
    expect(on.json).toMatchObject({ liked: true })
    const off = await call("POST", `/api/replies/${answer}/useful`, { token: camille.jwt })
    expect(off.json).toMatchObject({ liked: false })
    expect([401, 403]).toContain((await call("POST", `/api/replies/${answer}/useful`)).status)
  })
})
