import { afterAll, beforeAll, describe, expect, it } from "vitest"
import { call, categoryId, draft, loginDemoMember, type Member } from "./support"

let camille: Member
let vincent: Member
let discussion: string
const blogPosts: { token: string; documentId: string }[] = []

const profile = async (member: Member) => (await call("GET", "/api/users/me", { token: member.jwt })).json
const points = async (member: Member) =>
  (await call("GET", `/api/users?filters[username][$eq]=${member.username}&fields[0]=points`, { token: member.jwt })).json[0].points
const notifications = async (member: Member) => (await call("GET", "/api/notifications", { token: member.jwt })).json.data

const longText = "Je verse chaque mois la même somme sur un ETF monde, voici mon bilan après cinq ans de pratique."

beforeAll(async () => {
  camille = await loginDemoMember("Camille_B")
  vincent = await loginDemoMember("Vincent_ETF")
  const created = await call("POST", "/api/discussions", {
    token: camille.jwt,
    body: { data: draft(await categoryId(camille.jwt, "bourse"), { title: "Fil de test pour la gamification" }) },
  })
  discussion = created.json.data.documentId
})

afterAll(async () => {
  await call("DELETE", `/api/discussions/${discussion}`, { token: camille.jwt })
  for (const { token, documentId } of blogPosts) await call("DELETE", `/api/blog-posts/${documentId}`, { token })
})

describe("points et badges (versés par Strapi)", () => {
  it("renvoie les points gagnés avec la publication et les ajoute au profil", async () => {
    const before = await points(vincent)
    const reply = await call("POST", "/api/replies", { token: vincent.jwt, body: { data: { content: "Comparez les frais.", discussion } } })
    expect(reply.json.meta.effects).toContainEqual({ kind: "points", points: 3, reason: "Merci pour votre réponse", total: before + 3 })
    expect(await points(vincent)).toBe(before + 3)
  })

  it("refuse qu'un membre change ses propres points", async () => {
    const before = await points(camille)
    await call("PUT", "/api/users/me", { token: camille.jwt, body: { points: 99999, badges: ["pilier"] } })
    expect(await points(camille)).toBe(before)
  })

  it("interdit de marquer « Utile » son propre message", async () => {
    expect((await call("POST", `/api/discussions/${discussion}/useful`, { token: camille.jwt })).status).toBe(403)
  })

  it("ne récompense qu'une fois l'« Utile » d'un même membre, même retiré puis remis", async () => {
    const before = await points(camille)
    const first = await call("POST", `/api/discussions/${discussion}/useful`, { token: vincent.jwt })
    expect(first.json).toMatchObject({ liked: true, rewardedAuthor: "Camille" })
    await call("POST", `/api/discussions/${discussion}/useful`, { token: vincent.jwt })
    const again = await call("POST", `/api/discussions/${discussion}/useful`, { token: vincent.jwt })
    expect(again.json).toMatchObject({ liked: true, rewardedAuthor: null })
    expect(await points(camille)).toBe(before + 5)
  })
})

describe("notifications (créées par Strapi)", () => {
  it("prévient l'auteur d'une réponse à sa question, et les membres cités", async () => {
    const reply = await call("POST", "/api/replies", {
      token: vincent.jwt,
      body: { data: { content: "Bonne question, @Camille_B et @Odile.Retraite !", discussion } },
    })
    expect(reply.json.meta.mentioned.map((member: { username: string }) => member.username).sort()).toEqual(["Camille_B", "Odile.Retraite"])
    const mine = await notifications(camille)
    expect(mine[0]).toMatchObject({ actor: { username: "Vincent_ETF" }, discussion: { slug: expect.any(String) } })
    expect(mine.slice(0, 2).map((entry: { kind: string }) => entry.kind).sort()).toEqual(["mention", "reply"])
  })

  it("ne montre à un membre que ses propres notifications, et refuse les visiteurs", async () => {
    const vincentIds = new Set((await notifications(vincent)).map((entry: { documentId: string }) => entry.documentId))
    const camilles = await notifications(camille)
    expect(camilles.some((entry: { documentId: string }) => vincentIds.has(entry.documentId))).toBe(false)
    expect([401, 403]).toContain((await call("GET", "/api/notifications")).status)
  })

  it("ne laisse pas marquer comme lue la notification d'un autre", async () => {
    const [first] = await notifications(camille)
    expect((await call("POST", `/api/notifications/${first.documentId}/read`, { token: vincent.jwt })).status).toBe(404)
    const read = await call("POST", `/api/notifications/${first.documentId}/read`, { token: camille.jwt })
    expect(read.json.data.read).toBe(true)
  })

  it("n'expose aucune route de création", async () => {
    const result = await call("POST", "/api/notifications", { token: vincent.jwt, body: { data: { text: "Faux", kind: "badge" } } })
    expect([403, 404, 405]).toContain(result.status)
  })
})

describe("billets", () => {
  const publish = async (member: Member, data: Record<string, unknown>) => {
    const result = await call("POST", "/api/blog-posts", { token: member.jwt, body: { data } })
    if (result.status === 201) blogPosts.push({ token: member.jwt, documentId: result.json.data.documentId })
    return result
  }

  it("refuse un visiteur", async () => {
    expect([401, 403]).toContain((await call("POST", "/api/blog-posts", { body: { data: { title: "Un billet anonyme", content: longText } } })).status)
  })

  it("applique les règles côté Strapi (titre de 10 caractères, texte de 60)", async () => {
    expect((await publish(camille, { title: "Court", content: longText })).status).toBe(400)
    expect((await publish(camille, { title: "Un titre assez long", content: "Trop bref." })).status).toBe(400)
  })

  it("attribue le billet au membre connecté et lui verse ses points", async () => {
    const result = await publish(camille, { title: "Mon bilan de test", content: longText, author: vincent.id, usefulBase: 99 })
    expect(result.status).toBe(201)
    expect(result.json.data.author.username).toBe("Camille_B")
    expect(result.json.data.usefulBase).toBe(0)
    expect(result.json.meta.effects).toContainEqual(expect.objectContaining({ kind: "points", points: 5, reason: "Billet publié" }))
  })

  it("interdit à un autre membre de modifier ou supprimer le billet", async () => {
    const mine = await publish(camille, { title: "Billet protégé de test", content: longText })
    const documentId = mine.json.data.documentId
    expect((await call("PUT", `/api/blog-posts/${documentId}`, { token: vincent.jwt, body: { data: { title: "Titre détourné ici" } } })).status).toBe(403)
    expect((await call("DELETE", `/api/blog-posts/${documentId}`, { token: vincent.jwt })).status).toBe(403)
  })

  it("rattache un commentaire au billet et prévient son auteur", async () => {
    const mine = await publish(camille, { title: "Billet commenté de test", content: longText })
    const comment = await call("POST", "/api/blog-comments", {
      token: vincent.jwt,
      body: { data: { content: "Merci pour ce retour.", post: mine.json.data.documentId } },
    })
    expect(comment.status).toBe(201)
    expect((await notifications(camille))[0]).toMatchObject({ kind: "reply", text: "a commenté votre billet" })
  })
})

describe("policies de propriété (Strapi)", () => {
  const publishPost = async (member: Member) => {
    const result = await call("POST", "/api/blog-posts", { token: member.jwt, body: { data: { title: "Billet pour les policies", content: longText } } })
    blogPosts.push({ token: member.jwt, documentId: result.json.data.documentId })
    return result.json.data.documentId as string
  }

  it("interdit le « Utile » sur son propre billet, sa propre réponse et son propre commentaire", async () => {
    const post = await publishPost(camille)
    expect((await call("POST", `/api/blog-posts/${post}/useful`, { token: camille.jwt })).status).toBe(403)

    const reply = await call("POST", "/api/replies", { token: camille.jwt, body: { data: { content: "Ma propre réponse.", discussion } } })
    expect((await call("POST", `/api/replies/${reply.json.data.documentId}/useful`, { token: camille.jwt })).status).toBe(403)

    const comment = await call("POST", "/api/blog-comments", { token: camille.jwt, body: { data: { content: "Mon commentaire.", post } } })
    expect((await call("POST", `/api/blog-comments/${comment.json.data.documentId}/useful`, { token: camille.jwt })).status).toBe(403)
  })

  it("laisse un autre membre marquer « Utile » un billet, et refuse de supprimer le commentaire d'autrui", async () => {
    const post = await publishPost(camille)
    expect((await call("POST", `/api/blog-posts/${post}/useful`, { token: vincent.jwt })).status).toBe(200)
    const comment = await call("POST", "/api/blog-comments", { token: camille.jwt, body: { data: { content: "Mon commentaire.", post } } })
    const documentId = comment.json.data.documentId
    expect((await call("DELETE", `/api/blog-comments/${documentId}`, { token: vincent.jwt })).status).toBe(403)
    expect((await call("DELETE", `/api/blog-comments/${documentId}`, { token: camille.jwt })).status).toBe(204)
  })

  it("répond 404 (et non 403) pour un contenu inexistant", async () => {
    expect((await call("DELETE", "/api/blog-posts/inexistant", { token: camille.jwt })).status).toBe(404)
    expect((await call("POST", "/api/replies/inexistant/useful", { token: camille.jwt })).status).toBe(404)
  })

  it("refuse toute écriture d'un visiteur, sur chaque route", async () => {
    for (const [method, path] of [
      ["POST", "/api/discussions"],
      ["POST", "/api/replies"],
      ["POST", "/api/blog-posts"],
      ["POST", "/api/blog-comments"],
      ["POST", `/api/discussions/${discussion}/vote`],
      ["POST", `/api/discussions/${discussion}/follow`],
      ["DELETE", `/api/discussions/${discussion}`],
      ["PUT", `/api/discussions/${discussion}`],
    ] as const) {
      expect([401, 403], `${method} ${path}`).toContain((await call(method, path, { body: { data: {} } })).status)
    }
  })
})

describe("rendez-vous", () => {
  it("inscrit puis désinscrit le membre connecté, et refuse les visiteurs", async () => {
    const events = await call("GET", "/api/events?sort=startsAt:asc", { token: camille.jwt })
    const event = events.json.data[0].documentId
    const on = await call("POST", `/api/events/${event}/rsvp`, { token: camille.jwt })
    const off = await call("POST", `/api/events/${event}/rsvp`, { token: camille.jwt })
    expect(on.json.joined).not.toBe(off.json.joined)
    expect([401, 403]).toContain((await call("POST", `/api/events/${event}/rsvp`)).status)
  })

  it("ne laisse pas un membre créer un rendez-vous", async () => {
    const result = await call("POST", "/api/events", { token: camille.jwt, body: { data: { title: "Faux", host: "x", startsAt: new Date().toISOString() } } })
    expect([403, 404, 405]).toContain(result.status)
  })
})

describe("inscription", () => {
  /**
   * Garde-fou d'intégration : Users & Permissions fabrique son controller `auth` plus tard, donc une extension mal
   * branchée ne lève aucune erreur et ne fait rien. Seule une vraie inscription le révèle.
   * L'API ne permet pas à un membre de supprimer son compte : ce test laisse un compte `zz_test_…` par exécution.
   */
  it("verse les points et le badge de bienvenue au nouveau membre", async () => {
    const name = `zz_test_${Date.now().toString(36)}`;
    const result = await call("POST", "/api/auth/local/register", {
      body: { username: name, email: `${name}@demo.lerevenu.test`, password: "Relecture2026ok" },
    });
    expect(result.status).toBe(200);
    expect(result.json.effects).toEqual(
      expect.arrayContaining([expect.objectContaining({ kind: "points", points: 5, reason: "Bienvenue dans la communauté !" }), { kind: "badge", code: "bienvenue" }])
    );
    const me = await call("GET", "/api/users/me", { token: result.json.jwt });
    expect(me.json).toMatchObject({ username: name, points: 5, badges: ["bienvenue"] });
    expect((await notifications({ jwt: result.json.jwt } as Member))[0]).toMatchObject({ kind: "badge" });
  });
});

describe("profil", () => {
  it("expose la gamification du membre connecté sans permettre de la modifier", async () => {
    expect(await profile(camille)).toMatchObject({ username: "Camille_B" })
  })
})
