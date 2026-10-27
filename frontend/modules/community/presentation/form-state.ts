import type { UiEffect } from "./action-result"

export type FormState = {
  fieldErrors?: Record<string, string>
  formError?: string
  sent?: number
  effects?: UiEffect[]
}

export type ComposeValues = {
  type: string
  title: string
  category: string
  content: string
  options: string[]
  article: string
}

export type ComposeState = FormState & {
  values?: ComposeValues
  created?: { id: string; effects: UiEffect[]; at: number }
}

export type BlogValues = { title: string; category: string; content: string }

export type BlogState = FormState & {
  values?: BlogValues
  created?: { id: string; effects: UiEffect[]; at: number }
}
