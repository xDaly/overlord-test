import { Search } from "lucide-react"
import type { Metadata } from "next"
import Form from "next/form"
import Link from "next/link"

import { AskButton } from "@/components/community/ask-button"
import { DiscussionCard } from "@/components/community/discussion-card"
import { PageLayout } from "@/components/community/page-layout"
import { Button } from "@/components/ui/button"
import { Card } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { community } from "@/modules/community/community.container"
import { getSessionUser, getViewFlags } from "@/modules/community/presentation/session"

export const metadata: Metadata = { title: "Rechercher" }

const SUGGESTIONS = ["PEA", "assurance-vie", "donation", "SCPI", "PER", "frais réels"]

type SearchProps = { searchParams: Promise<{ q?: string }> }

export default async function SearchPage({ searchParams }: SearchProps) {
  const query = ((await searchParams).q ?? "").trim()
  const [viewer, flags] = await Promise.all([getSessionUser(), getViewFlags()])
  const results = query ? await community().discussions.search(query, viewer?.username) : []

  return (
    <PageLayout>
      <header>
        <h1 className="font-display text-[28px] font-bold tracking-[-.01em]">Rechercher</h1>
      </header>
      <Form
        action="/recherche"
        role="search"
        className="flex h-9 items-center gap-2 rounded-[10px] border border-line bg-card px-3 text-sm text-ink-3 transition-[background-color,box-shadow] focus-within:border-brand focus-within:ring-3 focus-within:ring-brand/25"
      >
        <Search className="size-[18px] shrink-0" />
        <Input
          key={query}
          name="q"
          defaultValue={query}
          placeholder="PEA, donation, SCPI…"
          autoComplete="off"
          aria-label="Rechercher une discussion"
          className="h-full rounded-none border-0 bg-transparent px-0 text-sm shadow-none focus-visible:border-0 focus-visible:ring-0"
        />
      </Form>
      {query ? (
        <>
          <p className="text-ink-3">
            <span className="tabular-nums">{results.length}</span> résultat{results.length > 1 ? "s" : ""} pour «{" "}
            {query} »
          </p>
          {results.length ? (
            <div className="flex flex-col overflow-hidden rounded-lg border border-hairline bg-card shadow-card">
              {results.map((discussion) => (
                <DiscussionCard key={discussion.id} discussion={discussion} staff={flags.staff} />
              ))}
            </div>
          ) : (
            <Card className="px-5 py-10 text-center text-ink-2">
              <h3 className="mb-1.5 font-display text-xl font-bold tracking-[-.01em] text-foreground">
                Aucune discussion trouvée
              </h3>
              <p>Posez la question à la communauté : quelqu&apos;un a sûrement vécu la même situation.</p>
              <AskButton title={query} />
            </Card>
          )}
        </>
      ) : (
        <div className="flex flex-wrap gap-2">
          {SUGGESTIONS.map((suggestion) => (
            <Button
              key={suggestion}
              variant="secondary"
              nativeButton={false}
              render={<Link href={`/recherche?q=${encodeURIComponent(suggestion)}`} />}
              className="h-auto rounded-full px-[13px] py-1.5 text-[13.5px] font-medium text-ink-2"
            >
              {suggestion}
            </Button>
          ))}
        </div>
      )}
    </PageLayout>
  )
}
