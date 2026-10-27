const MESSAGES: Record<string, string> = {
  "identifier.required": "Saisissez votre adresse e-mail ou votre identifiant.",
  "password.required": "Saisissez votre mot de passe.",
  "username.invalid": "L'identifiant compte de 3 à 24 caractères : lettres sans accent, chiffres et tirets bas.",
  "email.invalid": "Saisissez une adresse e-mail valide.",
  "password.tooShort": "Le mot de passe doit compter au moins 8 caractères.",
  "password.weak": "Le mot de passe doit contenir au moins une lettre et un chiffre.",
  "credentials.invalid": "Adresse e-mail ou mot de passe incorrect.",
  "account.taken": "Cette adresse e-mail ou cet identifiant est déjà utilisé.",
  "register.invalid": "L'inscription a échoué. Vérifiez les informations saisies.",
  "rate.limited": "Trop de tentatives. Patientez une minute avant de réessayer.",
}

export const UNAVAILABLE_MESSAGE = "Le service est momentanément indisponible. Réessayez dans un instant."

export const authMessage = (code: string | undefined) => (code ? (MESSAGES[code] ?? code) : undefined)
