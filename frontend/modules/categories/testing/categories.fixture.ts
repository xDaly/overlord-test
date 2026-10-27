import type { Category } from "../domain/category"

type Row = [string, string, string, string, string, number, number]

const ROWS: Row[] = [
  ["bourse", "Bourse & actions", "Actions, ETF, PEA, compte-titres : stratégies et retours d'expérience.", "candles", "#007aff", 412, 3108],
  ["economie", "Économie", "Conjoncture, taux, inflation, emploi : l'actualité économique en France, en Europe et dans le monde.", "globe", "#3d5a80", 156, 1180],
  ["epargne", "Épargne & placements", "Livrets, fonds euros, obligations, comptes à terme.", "piggy", "#34c759", 268, 1934],
  ["assurance-vie", "Assurance-vie", "Choisir son contrat, arbitrer, transmettre.", "umbrella", "#30b0c7", 231, 1702],
  ["immobilier", "Immobilier & SCPI", "Résidence principale, locatif, SCPI, crédit immobilier.", "building", "#ff9500", 198, 1488],
  ["impots", "Impôts & fiscalité", "Déclaration, niches fiscales, IFI : payer le juste impôt.", "receipt", "#5856d6", 176, 1251],
  ["retraite", "Retraite", "PER, rachat de trimestres, cumul emploi-retraite.", "armchair", "#ff2d55", 143, 960],
  ["transmission", "Famille & transmission", "Donation, succession, protection du conjoint.", "family", "#af52de", 97, 702],
  ["alternatifs", "Or, cryptos & alternatifs", "Or physique, cryptoactifs, forêts, private equity.", "gem", "#00c7be", 88, 590],
  ["budget", "Budget & conso", "Banques, crédits, assurances, bons plans.", "wallet", "#8e8e93", 121, 845],
  ["cafe", "Le Café du Revenu", "Présentations, discussions libres, idées pour la rédaction.", "coffee", "#a2845e", 74, 1120],
]

const SITE_SECTIONS: Record<string, string> = {
  bourse: "Réussir en Bourse",
  economie: "Économie",
  epargne: "Diversifier vos placements",
  "assurance-vie": "Diversifier vos placements",
  immobilier: "Investir dans l'immobilier",
  impots: "Réduire vos impôts",
  retraite: "Diversifier vos placements",
  transmission: "Préparer une succession",
  alternatifs: "Diversifier vos placements",
  budget: "Vie pratique",
}

export const CATEGORY_FIXTURES: Category[] = ROWS.map(
  ([slug, name, description, icon, color, topicsCount, repliesCount]) => ({
    slug,
    name,
    description,
    icon,
    color,
    topicsCount,
    repliesCount,
    siteSection: SITE_SECTIONS[slug] ?? null,
  })
)
