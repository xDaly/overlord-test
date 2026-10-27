import type { FieldErrors } from "@/lib/errors"

const MESSAGES: Record<string, string> = {
  "pseudo.tooShort": "Choisissez un pseudo d'au moins 3 caractères.",
  "bio.tooLong": "La présentation est limitée à 280 caractères.",
  "photo.required": "Choisissez une image.",
  "photo.invalidType": "Choisissez une image JPG, PNG, WebP ou GIF.",
  "photo.tooLarge": "L'image est trop lourde : 2 Mo au maximum.",
  "photo.rejected": "Cette image n'a pas été acceptée. Essayez un autre fichier JPG ou PNG.",
  "profile.invalid": "Le profil n'a pas pu être enregistré. Vérifiez les informations saisies.",
}

export const PROFILE_FALLBACK = "L'enregistrement a échoué. Réessayez dans un instant."

export function profileMessage(fields: FieldErrors): string | undefined {
  const code = fields.pseudo ?? fields.bio ?? fields.photo ?? fields.form
  return code ? (MESSAGES[code] ?? code) : undefined
}
