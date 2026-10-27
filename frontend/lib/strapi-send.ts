import { AppError } from "@/lib/errors"

export type StrapiRequest = {
  method: string
  headers?: Record<string, string>
  json?: unknown
  form?: FormData
}

export async function strapiSend(
  fetchImpl: typeof fetch,
  baseUrl: string,
  path: string,
  { method, headers, json, form }: StrapiRequest
): Promise<Response> {
  try {
    return await fetchImpl(`${baseUrl}${path}`, {
      method,
      headers: { ...(json !== undefined ? { "Content-Type": "application/json" } : {}), ...headers },
      body: form ?? (json === undefined ? undefined : JSON.stringify(json)),
      cache: "no-store",
    })
  } catch {
    throw new AppError("unavailable")
  }
}
