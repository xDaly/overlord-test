import { DISCUSSION_TYPES, type DiscussionType } from "./discussion"

export const MIN_TITLE_LENGTH = 10
export const MAX_TITLE_LENGTH = 150
export const MIN_REPLY_LENGTH = 2
export const MIN_POLL_OPTIONS = 2
export const MAX_POLL_OPTIONS = 6
export const MAX_OPTION_LENGTH = 80

export type NewDiscussionInput = {
  title: string
  content: string
  type: DiscussionType
  categorySlug: string
  options?: string[]
  article?: string
}

export type NewDiscussionErrors = Partial<
  Record<"title" | "content" | "category" | "type" | "options", string>
>

export const normalizeTitle = (title: string) => title.trim().replace(/\s+/g, " ")

export function validateNewDiscussion(input: NewDiscussionInput): NewDiscussionErrors {
  const errors: NewDiscussionErrors = {}
  if (normalizeTitle(input.title).length < MIN_TITLE_LENGTH) errors.title = "title.tooShort"
  if (input.type !== "poll" && !input.content.trim()) errors.content = "content.required"
  if (!input.categorySlug) errors.category = "category.required"
  if (!DISCUSSION_TYPES.includes(input.type)) errors.type = "type.invalid"
  if (input.type === "poll") {
    const filled = (input.options ?? []).map((option) => option.trim()).filter(Boolean)
    if (filled.length < MIN_POLL_OPTIONS) errors.options = "options.tooFew"
  }
  return errors
}
