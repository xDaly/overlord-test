import { errors } from "@strapi/utils";

const { ValidationError } = errors;

export const DISPLAY_NAME_MIN = 3;
export const DISPLAY_NAME_MAX = 24;
export const BIO_MAX = 280;
export const INTERESTS_MAX = 12;
export const AVATAR_MAX_BYTES = 2 * 1024 * 1024;
export const AVATAR_TYPES = ["image/jpeg", "image/png", "image/webp", "image/gif"] as const;

const INTEREST_PATTERN = /^[a-z0-9-]{1,40}$/;

type Data = Record<string, unknown>;

const isData = (value: unknown): value is Data => typeof value === "object" && value !== null && !Array.isArray(value);

/**
 * Champs qu'un membre peut changer sur son propre profil.
 * Tout le reste (identifiant, e-mail, rôle, blocage, mot de passe, avatar) est ignoré : l'avatar a sa propre route.
 */
export function parseProfileUpdate(body: unknown): { displayName?: string; bio?: string; interests?: string[] } {
  if (!isData(body)) throw new ValidationError("Missing profile data");
  const update: { displayName?: string; bio?: string; interests?: string[] } = {};

  if ("displayName" in body) {
    const name = typeof body.displayName === "string" ? body.displayName.trim().replace(/\s+/g, " ") : "";
    if (name.length < DISPLAY_NAME_MIN || name.length > DISPLAY_NAME_MAX) {
      throw new ValidationError(`displayName must be ${DISPLAY_NAME_MIN} to ${DISPLAY_NAME_MAX} characters`);
    }
    update.displayName = name;
  }

  if ("bio" in body) {
    const bio = typeof body.bio === "string" ? body.bio.trim() : null;
    if (bio === null || bio.length > BIO_MAX) throw new ValidationError(`bio must be at most ${BIO_MAX} characters`);
    update.bio = bio;
  }

  if ("interests" in body) {
    const { interests } = body;
    const valid =
      Array.isArray(interests) &&
      interests.length <= INTERESTS_MAX &&
      interests.every((entry) => typeof entry === "string" && INTEREST_PATTERN.test(entry));
    if (!valid) throw new ValidationError("interests must be a short list of space slugs");
    update.interests = [...new Set(interests as string[])];
  }

  if (Object.keys(update).length === 0) throw new ValidationError("Nothing to update");
  return update;
}

export function assertAvatarFile(file: { mimetype?: string; size?: number } | undefined): void {
  if (!file) throw new ValidationError("Missing avatar file");
  if (!AVATAR_TYPES.includes(file.mimetype as (typeof AVATAR_TYPES)[number])) {
    throw new ValidationError("Avatar must be a JPEG, PNG, WebP or GIF image");
  }
  if (typeof file.size !== "number" || file.size > AVATAR_MAX_BYTES) {
    throw new ValidationError("Avatar must be 2 MB or smaller");
  }
}

/** Profil renvoyé au membre connecté : ses propres données, sans champ technique. */
export function toOwnProfile(user: Data) {
  const avatar = isData(user.avatar) ? { id: user.avatar.id, url: user.avatar.url } : null;
  return {
    id: user.id,
    documentId: user.documentId,
    username: user.username,
    email: user.email,
    displayName: user.displayName ?? null,
    bio: user.bio ?? null,
    interests: Array.isArray(user.interests) ? user.interests : [],
    avatar,
  };
}
