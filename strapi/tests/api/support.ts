/**
 * Aides des tests d'API : ils parlent à un Strapi réellement démarré (`npm run dev:strapi`) dont la base contient
 * les données de démonstration (`npm run seed -w strapi`). Ils utilisent des membres de démonstration et suppriment
 * tout ce qu'ils créent.
 */
export const BASE_URL = process.env.STRAPI_URL ?? "http://localhost:1337";

export type Reply = { status: number; json: any };

export const call = async (method: string, path: string, options: { token?: string; body?: unknown } = {}): Promise<Reply> => {
  const response = await fetch(BASE_URL + path, {
    method,
    headers: {
      ...(options.body ? { "Content-Type": "application/json" } : {}),
      ...(options.token ? { Authorization: `Bearer ${options.token}` } : {}),
    },
    body: options.body ? JSON.stringify(options.body) : undefined,
  });
  const json = await response.json().catch(() => null);
  return { status: response.status, json };
};

export type Member = { jwt: string; id: number; username: string };

/** Ouvre une session avec un membre de démonstration ; échoue avec un message clair si Strapi ou le seed manque. */
export async function loginDemoMember(username: string): Promise<Member> {
  const password = process.env.SEED_USER_PASSWORD
  if (!password) throw new Error("SEED_USER_PASSWORD est absent : lancez les tests avec `npm run test:api -w strapi` (il lit le .env racine).")
  const result = await call("POST", "/api/auth/local", { body: { identifier: username, password } }).catch((error: Error & { cause?: { code?: string } }) => {
    throw new Error(`Strapi ne répond pas sur ${BASE_URL} (${error.cause?.code ?? error.message}) : démarrez-le avec \`npm run dev:strapi\`.`)
  })
  if (result.status !== 200) throw new Error(`Connexion de ${username} refusée (${result.status}) : lancez \`npm run seed -w strapi\`.`)
  return { jwt: result.json.jwt, id: result.json.user.id, username: result.json.user.username }
}

/** Identifiant (documentId) d'un espace de la base. */
export async function categoryId(token: string, slug: string): Promise<string> {
  const result = await call("GET", `/api/categories?filters[slug][$eq]=${slug}`, { token })
  return result.json.data[0].documentId
}

export const draft = (category: string, overrides: Record<string, unknown> = {}) => ({
  title: "Comment choisir un courtier en ligne ?",
  content: "Je débute et je compare les frais.",
  type: "question",
  category,
  ...overrides,
})

export const DEMO_EMAIL_DOMAIN = "@demo.lerevenu.test"
