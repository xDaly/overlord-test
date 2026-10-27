export type StrapiParam = string | number | boolean | null | undefined | StrapiParam[] | { [key: string]: StrapiParam }
export type StrapiParams = { [key: string]: StrapiParam }

const encodeKey = (key: string) => encodeURIComponent(key).replace(/%5B/g, "[").replace(/%5D/g, "]")

export function toQuery(params: StrapiParams): string {
  const pairs: string[] = []
  const walk = (value: StrapiParam, key: string) => {
    if (value === undefined || value === null) return
    if (Array.isArray(value)) value.forEach((entry, index) => walk(entry, `${key}[${index}]`))
    else if (typeof value === "object") for (const [name, entry] of Object.entries(value)) walk(entry, `${key}[${name}]`)
    else pairs.push(`${encodeKey(key)}=${encodeURIComponent(String(value))}`)
  }
  for (const [key, value] of Object.entries(params)) walk(value, key)
  return pairs.join("&")
}
