export const SEO_USEFUL_THRESHOLD = 25

export type SeoInput = {
  categorySlug: string
  usefulCount: number
  repliesCount: number
  solutionVerified: boolean | null
  hasExpertParticipant: boolean
  expertIsRedaction: boolean
}

export type SeoStatus = {
  on: boolean
  reason: string
  checks: [label: string, passed: boolean][]
}

export function seoStatus(input: SeoInput): SeoStatus {
  const enoughUseful = input.usefulCount >= SEO_USEFUL_THRESHOLD && input.repliesCount >= 2
  const checks: SeoStatus["checks"] = [
    ["Espace indexable (hors Café du Revenu)", input.categorySlug !== "cafe"],
    ["Meilleure réponse choisie", input.solutionVerified !== null],
    ["Contribution de la rédaction ou d'un expert vérifié", input.hasExpertParticipant],
    [`Au moins ${SEO_USEFUL_THRESHOLD} « Utile » et deux réponses`, enoughUseful],
  ]
  if (input.categorySlug === "cafe") return { on: false, reason: "Espace de discussion libre : jamais indexé", checks }
  if (input.solutionVerified !== null)
    return {
      on: true,
      reason: input.solutionVerified ? "Meilleure réponse vérifiée par la rédaction" : "Meilleure réponse choisie",
      checks,
    }
  if (input.hasExpertParticipant)
    return {
      on: true,
      reason: input.expertIsRedaction ? "Contribution de la rédaction" : "Réponse d'un expert vérifié",
      checks,
    }
  if (enoughUseful) return { on: true, reason: `Discussion jugée utile (${input.usefulCount} « Utile »)`, checks }
  return {
    on: false,
    reason: input.repliesCount ? "Pas encore assez de signaux de qualité" : "Pas encore de réponse",
    checks,
  }
}

export const BLOG_SEO_THRESHOLD = 20

export const blogSeo = (likes: number): { on: boolean; reason: string } =>
  likes >= BLOG_SEO_THRESHOLD
    ? { on: true, reason: "Billet apprécié des lecteurs" }
    : { on: false, reason: "En attente de relecture par la rédaction" }
