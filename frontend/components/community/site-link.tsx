import type { ComponentProps } from "react"

export const SITE_URL = "https://www.lerevenu.com"

export function SiteLink(props: Omit<ComponentProps<"a">, "href" | "target" | "rel">) {
  return <a href={SITE_URL} target="_blank" rel="noopener" {...props} />
}
