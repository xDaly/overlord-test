/**
 * Règles de la gamification : points, niveaux et badges. Fonctions pures, appliquées par le service `reward`.
 */

export const BADGES = {
  bienvenue: "Bienvenue",
  premier_sujet: "Premier pas",
  premiere_reponse: "Entraide",
  apprecie: "Apprécié",
  populaire: "Populaire",
  solution: "Bonne réponse",
  sondeur: "Sondeur",
  citoyen: "Votre avis compte",
  assidu: "Assidu",
  pilier: "Pilier des échanges",
} as const;

export type BadgeCode = keyof typeof BADGES;

export const isBadge = (value: unknown): value is BadgeCode => typeof value === "string" && value in BADGES;

export const LEVELS: ReadonlyArray<readonly [min: number, name: string]> = [
  [0, "Nouveau venu"],
  [25, "Membre"],
  [100, "Contributeur"],
  [300, "Contributeur averti"],
  [750, "Pilier de la communauté"],
];

export function levelIndex(points: number): number {
  let index = 0;
  LEVELS.forEach(([min], i) => {
    if (points >= min) index = i;
  });
  return index;
}

/** Points versés par action ; le front les affiche dans le barème mais ne les applique jamais. */
export const POINTS = {
  welcome: 5,
  discussion: 5,
  reply: 3,
  useful: 5,
  solution: 20,
  vote: 1,
  blogPost: 5,
  blogComment: 3,
} as const;

export const STAT_KEYS = ["topics", "replies", "likes", "solutions", "votes"] as const;
export type Stats = Record<(typeof STAT_KEYS)[number], number>;

/** Badges gagnés automatiquement quand un compteur atteint son seuil. */
const THRESHOLDS: ReadonlyArray<readonly [BadgeCode, keyof Stats, number]> = [
  ["premier_sujet", "topics", 1],
  ["premiere_reponse", "replies", 1],
  ["pilier", "replies", 50],
  ["apprecie", "likes", 1],
  ["populaire", "likes", 25],
  ["solution", "solutions", 1],
  ["citoyen", "votes", 3],
];

export type Profile = {
  points: number;
  monthPoints: number;
  monthKey: string | null;
  badges: BadgeCode[];
  stats: Stats;
};

export type RewardPlan = {
  points?: { amount: number; reason: string };
  stats?: Partial<Stats>;
  /** Badges liés à l'action elle-même (bienvenue, sondeur) ; les autres découlent des compteurs. */
  badges?: BadgeCode[];
};

/** Retour visuel renvoyé au front, qui en fait des notifications discrètes. */
export type Effect =
  | { kind: "points"; points: number; reason: string; total: number }
  | { kind: "level"; name: string }
  | { kind: "badge"; code: BadgeCode };

export const monthKeyOf = (date: Date) => date.toISOString().slice(0, 7);

/** Lit le profil d'un compte Strapi en tolérant les champs vides (compte créé dans l'administration). */
export function readProfile(user: Record<string, unknown>): Profile {
  const stats = (typeof user.stats === "object" && user.stats !== null ? user.stats : {}) as Record<string, unknown>;
  return {
    points: Number(user.points) || 0,
    monthPoints: Number(user.monthPoints) || 0,
    monthKey: typeof user.monthKey === "string" ? user.monthKey : null,
    badges: Array.isArray(user.badges) ? user.badges.filter(isBadge) : [],
    stats: Object.fromEntries(STAT_KEYS.map((key) => [key, Number(stats[key]) || 0])) as Stats,
  };
}

/** Applique une récompense : compteurs, puis points (avec remise à zéro mensuelle), puis badges. */
export function applyReward(profile: Profile, plan: RewardPlan, now: Date): { profile: Profile; effects: Effect[] } {
  const effects: Effect[] = [];
  const stats = { ...profile.stats };
  for (const key of STAT_KEYS) stats[key] += plan.stats?.[key] ?? 0;

  const month = monthKeyOf(now);
  let { points, monthPoints } = profile;
  if (profile.monthKey !== month) monthPoints = 0;
  if (plan.points && plan.points.amount > 0) {
    const before = levelIndex(points);
    points += plan.points.amount;
    monthPoints += plan.points.amount;
    effects.push({ kind: "points", points: plan.points.amount, reason: plan.points.reason, total: points });
    const after = levelIndex(points);
    if (after > before) effects.push({ kind: "level", name: LEVELS[after][1] });
  }

  const earned = [
    ...(plan.badges ?? []),
    ...THRESHOLDS.filter(([, key, min]) => stats[key] >= min).map(([code]) => code),
  ];
  const badges = [...profile.badges];
  for (const code of earned) {
    if (badges.includes(code)) continue;
    badges.push(code);
    effects.push({ kind: "badge", code });
  }

  return { profile: { points, monthPoints, monthKey: month, badges, stats }, effects };
}

const MENTION = /@([A-Za-z0-9_-]+(?:\.[A-Za-z0-9_-]+)*)/g;

/** Identifiants @ cités dans un texte, sans doublon. */
export function mentionedHandles(text: string): string[] {
  return [...new Set([...text.matchAll(MENTION)].map((match) => match[1]))];
}
