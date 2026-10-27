export type Category = {
  slug: string
  name: string
  description: string
  icon: string
  color: string
  topicsCount: number
  repliesCount: number
  siteSection: string | null
}

export const unknownCategory = (slug: string, name?: string): Category => ({
  slug,
  name: name ?? slug,
  description: "",
  icon: "coffee",
  color: "#8e8e93",
  topicsCount: 0,
  repliesCount: 0,
  siteSection: null,
})
