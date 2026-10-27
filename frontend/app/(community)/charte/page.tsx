import type { Metadata } from "next"

import { NotePin } from "@/components/community/notes"
import { PageLayout } from "@/components/community/page-layout"

export const metadata: Metadata = { title: "La charte de la communauté" }

const RULES: [title: string, text: string][] = [
  ["Bienveillance", "On débat des idées, jamais des personnes. Les débutants sont les bienvenus : aucune question n'est bête."],
  ["Expérience, pas conseil personnalisé", "Partagez ce que vous faites et pourquoi. Chacun reste responsable de ses décisions d'investissement."],
  ["Pas de sollicitation", "Aucune promotion de produit, de parrainage ou de service payant."],
  [
    "Des liens vers des sources fiables",
    "Pour éviter la publicité déguisée, seuls les liens vers lerevenu.com et les sources officielles (sites publics, AMF, Banque de France, Insee, Cour des comptes) sont acceptés. Les autres liens sont réservés aux membres confirmés et vérifiés par la modération avant d'être cliquables.",
  ],
  ["Pas de rumeurs de marché", "Les « tuyaux » non sourcés et les incitations à acheter ou vendre un titre sont supprimés."],
  [
    "Protégez-vous",
    "Un pseudonyme suffit pour participer : seuls les professionnels vérifiés apparaissent sous leur nom. Ne publiez jamais vos coordonnées bancaires, numéros de contrat ou informations permettant de vous identifier.",
  ],
  ["Signalez plutôt que répondre", "Un message vous semble problématique ? Utilisez « Signaler » : l'équipe de modération intervient rapidement."],
]

export default function CharterPage() {
  return (
    <PageLayout active="charter">
      <header>
        <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">
          La charte de la communauté <NotePin k="compliance" />
        </h1>
        <p className="mt-1.5 max-w-[62ch] text-ink-2">
          Sept règles simples pour que les échanges restent utiles, sûrs et agréables. Elles se lisent en deux minutes.
        </p>
      </header>
      <ol className="flex flex-col gap-3">
        {RULES.map(([title, text], index) => (
          <li
            key={title}
            className="grid grid-cols-[36px_minmax(0,1fr)] gap-3 rounded-lg border border-hairline bg-card p-4 shadow-card"
          >
            <span className="w-9 text-center font-display text-[30px] leading-none font-black text-brand-text">
              {index + 1}
            </span>
            <div>
              <h3 className="text-base font-bold">{title}</h3>
              <p className="mt-0.5 text-[14.5px] text-ink-2">{text}</p>
            </div>
          </li>
        ))}
      </ol>
    </PageLayout>
  )
}
