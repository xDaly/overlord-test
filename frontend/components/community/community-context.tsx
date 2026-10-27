"use client"

import { createContext, useContext, type ReactNode } from "react"

import type { Category } from "@/modules/categories/domain/category"
import type { SimilarCandidate } from "@/modules/discussions/domain/feed"
import type { User } from "@/modules/users/domain/user"

export type CommunityData = {
  user: User | null
  users: User[]
  categories: Category[]
  similar: SimilarCandidate[]
  staff: boolean
}

const Context = createContext<CommunityData | null>(null)

export function CommunityProvider({ value, children }: { value: CommunityData; children: ReactNode }) {
  return <Context.Provider value={value}>{children}</Context.Provider>
}

export function useCommunity(): CommunityData {
  const context = useContext(Context)
  if (!context) throw new Error("useCommunity doit être utilisé dans CommunityProvider")
  return context
}
