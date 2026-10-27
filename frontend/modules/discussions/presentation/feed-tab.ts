import type { FeedTab } from "../domain/feed"

export type { FeedTab }

export const FEED_TAB_LABELS: Record<FeedTab, string> = {
  "pour-vous": "Pour vous",
  tendances: "Tendances",
  recentes: "Récentes",
  "sans-reponse": "Sans réponse",
}

const KNOWN: FeedTab[] = ["pour-vous", "tendances", "recentes", "sans-reponse"]

export function resolveFeedTab(
  value: string | undefined,
  context: { logged: boolean; inCategory: boolean }
): FeedTab {
  const requested = KNOWN.find((tab) => tab === value)
  const personalised = context.logged && !context.inCategory
  if (requested === "pour-vous" && !personalised) return "tendances"
  return requested ?? (personalised ? "pour-vous" : "tendances")
}

export function availableTabs(context: { logged: boolean; inCategory: boolean }): FeedTab[] {
  const base: FeedTab[] = ["tendances", "recentes", "sans-reponse"]
  return context.logged && !context.inCategory ? ["pour-vous", ...base] : base
}
