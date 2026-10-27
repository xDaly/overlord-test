export const BADGES = {
  bienvenue: { name: "Bienvenue", description: "A rejoint la communauté", icon: "hand" },
  premier_sujet: { name: "Premier pas", description: "A lancé sa première discussion", icon: "pen" },
  premiere_reponse: { name: "Entraide", description: "A publié sa première réponse", icon: "msg" },
  apprecie: { name: "Apprécié", description: "A reçu son premier « Utile »", icon: "thumb" },
  populaire: { name: "Populaire", description: "A reçu 25 « Utile »", icon: "star" },
  solution: { name: "Bonne réponse", description: "Réponse choisie comme meilleure réponse", icon: "check" },
  sondeur: { name: "Sondeur", description: "A lancé un sondage", icon: "chart" },
  citoyen: { name: "Votre avis compte", description: "A voté à 3 sondages", icon: "vote" },
  assidu: { name: "Assidu", description: "7 jours de visite d'affilée", icon: "flame" },
  pilier: { name: "Pilier des échanges", description: "A publié 50 réponses", icon: "columns" },
} as const

export type BadgeCode = keyof typeof BADGES

export const BADGE_CODES = Object.keys(BADGES) as BadgeCode[]

export const POINTS_TABLE: ReadonlyArray<readonly [label: string, points: number]> = [
  ["Publier une réponse", 3],
  ["Lancer une discussion", 5],
  ["Publier un billet de blog", 5],
  ["Recevoir un « Utile »", 5],
  ["Meilleure réponse", 20],
  ["Voter à un sondage", 1],
  ["Visite quotidienne", 1],
]
