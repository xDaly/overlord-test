import { errors } from "@strapi/utils";

const { ForbiddenError, UnauthorizedError, ValidationError } = errors;

export type SessionUser = { id: number };

type Data = Record<string, unknown>;

export const DISCUSSION_EDITABLE = ["title", "content", "type", "category"] as const;

/** Profil public d'un membre : identité, présentation et gamification ; jamais l'e-mail ni les champs techniques. */
const PUBLIC_AUTHOR_FIELDS = [
  "id",
  "documentId",
  "username",
  "displayName",
  "bio",
  "avatar",
  "interests",
  "communityRole",
  "avatarColor",
  "subscriber",
  "expertTitle",
  "points",
  "monthPoints",
  "monthKey",
  "streak",
  "badges",
  "stats",
  "createdAt",
] as const;

const isData = (value: unknown): value is Data => typeof value === "object" && value !== null && !Array.isArray(value);

/** Une écriture exige un utilisateur connecté : sans lui, Strapi répond 401. */
export function requireUser<T extends SessionUser>(user: T | null | undefined): T {
  if (!user) throw new UnauthorizedError("Authentication required");
  return user;
}

/** L'auteur d'une publication est toujours l'utilisateur connecté, quoi que le client envoie. */
export function forceAuthor(data: unknown, user: SessionUser): Data {
  if (!isData(data)) throw new ValidationError("Missing data");
  return { ...data, author: user.id };
}

/** Une nouvelle réponse ne peut pas se déclarer meilleure réponse : seul l'auteur de la discussion le décide. */
export function forceReplyAuthor(data: unknown, user: SessionUser): Data {
  return { ...forceAuthor(data, user), isBestAnswer: false };
}

export function pickEditable(data: unknown, allowed: readonly string[]): Data {
  if (!isData(data)) throw new ValidationError("Missing data");
  return Object.fromEntries(Object.entries(data).filter(([key]) => allowed.includes(key)));
}

/** L'auteur d'une réponse modifie le texte ; l'auteur de la discussion désigne la meilleure réponse ; personne d'autre. */
export function authorizeReplyUpdate({
  authorId,
  discussionAuthorId,
  user,
  data,
}: {
  authorId: number | undefined;
  discussionAuthorId: number | undefined;
  user: SessionUser;
  data: unknown;
}): Data {
  const allowed: string[] = [];
  if (authorId === user.id) allowed.push("content");
  if (discussionAuthorId === user.id) allowed.push("isBestAnswer");
  const editable = pickEditable(data, allowed);
  if (Object.keys(editable).length === 0) throw new ForbiddenError("You cannot change this reply");
  return editable;
}

/** Un auteur n'expose jamais son e-mail ni ses champs techniques dans une discussion. */
export function toPublicAuthor<T>(author: T): T {
  if (!isData(author)) return author;
  return Object.fromEntries(Object.entries(author).filter(([key]) => (PUBLIC_AUTHOR_FIELDS as readonly string[]).includes(key))) as T;
}

type Entry = Data & { author?: unknown; replies?: unknown; comments?: unknown; discussion?: unknown; post?: unknown };

const scrubEntry = (entry: unknown): unknown => {
  if (!isData(entry)) return entry;
  const next: Entry = { ...entry };
  if ("author" in next) next.author = toPublicAuthor(next.author);
  for (const list of ["usefulBy", "followedBy", "attendees"] as const) {
    if (Array.isArray(next[list])) next[list] = (next[list] as unknown[]).map(toPublicAuthor);
  }
  for (const list of ["replies", "comments"] as const) {
    if (Array.isArray(next[list])) next[list] = (next[list] as unknown[]).map(scrubEntry);
  }
  for (const parent of ["discussion", "post"] as const) {
    if (isData(next[parent])) next[parent] = scrubEntry(next[parent]);
  }
  return next;
};

/** Nettoie les auteurs d'une réponse de l'API (liste ou entrée seule) avant de la renvoyer. */
export function scrubAuthors<T extends { data: unknown }>(payload: T): T {
  const { data } = payload;
  return { ...payload, data: Array.isArray(data) ? data.map(scrubEntry) : scrubEntry(data) };
}

/** Écart entre les permissions présentes et celles voulues pour un rôle. */
export function diffPermissions(existing: string[], desired: string[]) {
  return {
    toCreate: desired.filter((action) => !existing.includes(action)),
    toDelete: existing.filter((action) => !desired.includes(action)),
  };
}
