import { AppError, type FieldErrors } from "@/lib/errors"

export const MIN_PSEUDO_LENGTH = 3
export const MAX_PSEUDO_LENGTH = 24
export const BIO_MAX = 280
export const AVATAR_MAX_BYTES = 2 * 1024 * 1024
export const AVATAR_TYPES = ["image/jpeg", "image/png", "image/webp", "image/gif"] as const

export type ProfileInput = { pseudo: string; bio: string; interests: string[] }

export const normalizePseudo = (pseudo: string) => pseudo.trim().replace(/\s+/g, " ").slice(0, MAX_PSEUDO_LENGTH)

export function parseProfile(input: ProfileInput): ProfileInput {
  const pseudo = normalizePseudo(input.pseudo)
  const bio = input.bio.trim()
  const fields: FieldErrors = {}
  if (pseudo.length < MIN_PSEUDO_LENGTH) fields.pseudo = "pseudo.tooShort"
  if (bio.length > BIO_MAX) fields.bio = "bio.tooLong"
  if (Object.keys(fields).length > 0) throw new AppError("validation", fields)
  return { pseudo, bio, interests: [...new Set(input.interests)] }
}

export function assertAvatar(file: { type: string; size: number } | undefined): void {
  if (!file) throw new AppError("validation", { photo: "photo.required" })
  if (!(AVATAR_TYPES as readonly string[]).includes(file.type)) throw new AppError("validation", { photo: "photo.invalidType" })
  if (file.size > AVATAR_MAX_BYTES) throw new AppError("validation", { photo: "photo.tooLarge" })
}
