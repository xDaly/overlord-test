import { errors } from "@strapi/utils";

const { ValidationError } = errors;

export const BLOG_TITLE_MIN = 10;
export const BLOG_TITLE_MAX = 120;
export const BLOG_CONTENT_MIN = 60;
export const BLOG_CONTENT_MAX = 20_000;

const isData = (value: unknown): value is Record<string, unknown> =>
  typeof value === "object" && value !== null && !Array.isArray(value);

export type NewBlogPost = { title: string; content: string; category: string | null };

/** Seuls le titre, le texte et l'espace (facultatif) viennent du membre ; l'auteur et les compteurs sont fixés par Strapi. */
export function parseNewBlogPost(body: unknown): NewBlogPost {
  if (!isData(body)) throw new ValidationError("Missing data");

  const title = typeof body.title === "string" ? body.title.trim().replace(/\s+/g, " ") : "";
  if (title.length < BLOG_TITLE_MIN || title.length > BLOG_TITLE_MAX) {
    throw new ValidationError(`title must be ${BLOG_TITLE_MIN} to ${BLOG_TITLE_MAX} characters`);
  }

  const content = typeof body.content === "string" ? body.content.trim() : "";
  if (content.length < BLOG_CONTENT_MIN || content.length > BLOG_CONTENT_MAX) {
    throw new ValidationError(`content must be ${BLOG_CONTENT_MIN} to ${BLOG_CONTENT_MAX} characters`);
  }

  const category = typeof body.category === "string" && body.category ? body.category : null;
  return { title, content, category };
}
