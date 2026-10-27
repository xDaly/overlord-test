const DISCUSSION: Record<string, string> = {
  "title.tooShort":
    "Ajoutez quelques mots : un titre précis obtient plus de réponses (10 caractères minimum).",
  "content.required": "Ajoutez le contenu de votre message.",
  "content.links":
    "Ce message contient un lien que votre niveau ne permet pas encore de publier. Retirez-le ou gardez seulement les sources officielles.",
  "category.required": "Choisissez l'espace où publier.",
  "type.invalid": "Choisissez un type de publication.",
  "options.tooFew": "Un sondage a besoin d'au moins deux réponses.",
  "pseudo.tooShort": "Choisissez un pseudo d'au moins 3 caractères.",
}

const BLOG: Record<string, string> = {
  ...DISCUSSION,
  "title.tooShort": "Donnez un titre à votre billet (10 caractères minimum).",
  "content.tooShort": "Développez un peu votre récit : quelques phrases suffisent (60 caractères minimum).",
}

export const messageFor = (code: string | undefined, scope: "discussion" | "blog" = "discussion") =>
  code ? ((scope === "blog" ? BLOG : DISCUSSION)[code] ?? code) : undefined
