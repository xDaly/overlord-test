import { errors } from "@strapi/utils";

const { ValidationError } = errors;

export const TITLE_MIN = 10;
export const TITLE_MAX = 160;
export const CONTENT_MAX = 10_000;
export const POLL_OPTIONS_MIN = 2;
export const POLL_OPTIONS_MAX = 6;
export const POLL_OPTION_MAX = 80;
export const DISCUSSION_TYPES = ["question", "discussion", "poll"] as const;

type Data = Record<string, unknown>;
export type PollVotes = { counts: number[]; voters: Record<string, number> };

const isData = (value: unknown): value is Data => typeof value === "object" && value !== null && !Array.isArray(value);

/** Fragment d'URL lisible tiré d'un titre : sans accent, en minuscules, séparé par des tirets. */
export function slugify(text: string): string {
  const slug = text
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 80)
    .replace(/-+$/g, "");
  return slug || "discussion";
}

/** Ajoute un suffixe numérique tant que le fragment est déjà pris. */
export async function uniqueSlug(base: string, exists: (slug: string) => Promise<boolean>): Promise<string> {
  let candidate = base;
  for (let suffix = 2; await exists(candidate); suffix++) candidate = `${base}-${suffix}`;
  return candidate;
}

export type NewDiscussion = {
  title: string;
  content: string;
  type: (typeof DISCUSSION_TYPES)[number];
  category: unknown;
  article?: string;
  pollOptions?: string[];
  pollVotes?: PollVotes;
};

/**
 * Seuls ces champs viennent du membre ; l'auteur, l'adresse, les compteurs et l'épinglage sont décidés par Strapi.
 * Ces règles s'appliquent quel que soit le front : le titre minimal, le contenu, le type et les réponses du sondage.
 */
export function parseNewDiscussion(body: unknown): NewDiscussion {
  if (!isData(body)) throw new ValidationError("Missing data");

  const title = typeof body.title === "string" ? body.title.trim().replace(/\s+/g, " ") : "";
  if (title.length < TITLE_MIN || title.length > TITLE_MAX) {
    throw new ValidationError(`title must be ${TITLE_MIN} to ${TITLE_MAX} characters`);
  }

  const type = body.type as NewDiscussion["type"];
  if (!DISCUSSION_TYPES.includes(type)) throw new ValidationError("type must be question, discussion or poll");

  const content = typeof body.content === "string" ? body.content.trim() : "";
  if (type !== "poll" && !content) throw new ValidationError("content is required");
  if (content.length > CONTENT_MAX) throw new ValidationError(`content must be at most ${CONTENT_MAX} characters`);

  if (body.category === undefined || body.category === null || body.category === "") {
    throw new ValidationError("category is required");
  }

  const parsed: NewDiscussion = { title, content, type, category: body.category };

  if (typeof body.article === "string" && body.article.trim()) parsed.article = body.article.trim().slice(0, 200);

  if (type === "poll") {
    const options = (Array.isArray(body.pollOptions) ? body.pollOptions : [])
      .filter((option): option is string => typeof option === "string")
      .map((option) => option.trim())
      .filter(Boolean);
    if (options.length < POLL_OPTIONS_MIN || options.length > POLL_OPTIONS_MAX || options.some((o) => o.length > POLL_OPTION_MAX)) {
      throw new ValidationError(`a poll needs ${POLL_OPTIONS_MIN} to ${POLL_OPTIONS_MAX} options of at most ${POLL_OPTION_MAX} characters`);
    }
    parsed.pollOptions = options;
    parsed.pollVotes = { counts: options.map(() => 0), voters: {} };
  }

  return parsed;
}

/** Ajoute ou retire un membre d'une liste (« Utile », suivi). */
/** Le texte d'une réponse : obligatoire (les espaces seuls ne comptent pas) et borné. */
export function parseReplyContent(value: unknown): string {
  const content = typeof value === "string" ? value.trim() : "";
  if (!content) throw new ValidationError("content is required");
  if (content.length > CONTENT_MAX) throw new ValidationError(`content must be at most ${CONTENT_MAX} characters`);
  return content;
}

export function toggleId(ids: number[], id: number): { ids: number[]; active: boolean } {
  return ids.includes(id) ? { ids: ids.filter((entry) => entry !== id), active: false } : { ids: [...ids, id], active: true };
}

/** Un membre a une seule voix : voter à nouveau déplace son vote. */
export function castVote(
  votes: PollVotes | null,
  userId: number,
  option: unknown,
  optionCount: number
): { votes: PollVotes; first: boolean } {
  if (optionCount < 1 || !Number.isInteger(option) || (option as number) < 0 || (option as number) >= optionCount) {
    throw new ValidationError("Invalid poll option");
  }
  const choice = option as number;
  const counts = Array.from({ length: optionCount }, (_, index) => votes?.counts?.[index] ?? 0);
  const voters = { ...(votes?.voters ?? {}) };
  const previous = voters[String(userId)];
  if (previous === choice) return { votes: { counts, voters }, first: false };
  if (previous !== undefined) counts[previous] = Math.max(0, counts[previous] - 1);
  counts[choice] += 1;
  voters[String(userId)] = choice;
  return { votes: { counts, voters }, first: previous === undefined };
}
