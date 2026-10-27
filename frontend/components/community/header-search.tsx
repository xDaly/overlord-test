"use client"

import { Search } from "lucide-react"
import Form from "next/form"
import { useSearchParams } from "next/navigation"

import { Input } from "@/components/ui/input"

export function HeaderSearch() {
  const query = useSearchParams().get("q") ?? ""
  return (
    <Form
      action="/recherche"
      role="search"
      className="flex h-9 max-w-[420px] flex-1 items-center gap-2 rounded-[10px] border border-transparent bg-fill px-3 text-sm text-ink-3 transition-[background-color,box-shadow] focus-within:border-brand focus-within:bg-card focus-within:ring-3 focus-within:ring-brand/25 max-[860px]:hidden"
    >
      <Search className="size-[18px] shrink-0" />
      <Input
        key={query}
        name="q"
        defaultValue={query}
        placeholder="Rechercher une discussion, un sujet…"
        autoComplete="off"
        aria-label="Rechercher une discussion"
        className="h-full rounded-none border-0 bg-transparent px-0 text-sm shadow-none focus-visible:border-0 focus-visible:ring-0"
      />
    </Form>
  )
}
