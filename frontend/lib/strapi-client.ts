import { AppError } from "@/lib/errors"
import { toQuery, type StrapiParams } from "./strapi-query"
import { strapiSend } from "./strapi-send"

export type StrapiPagination = { page: number; pageSize: number; pageCount: number; total: number }
export type StrapiList<T> = { data: T[]; meta?: { pagination?: StrapiPagination } }
export type StrapiOne<T> = { data: T }

type Auth = {
  token?: string
}

export type StrapiClient = {
  get<T>(path: string, query?: StrapiParams, auth?: Auth): Promise<T>
  send<T>(method: "POST" | "PUT" | "DELETE", path: string, body?: unknown, auth?: Auth): Promise<T>
}

const messageOf = async (response: Response): Promise<string> => {
  try {
    return ((await response.json()) as { error?: { message?: string } }).error?.message ?? ""
  } catch {
    return ""
  }
}

async function failure(response: Response): Promise<AppError> {
  if (response.status === 401) return new AppError("unauthenticated")
  if (response.status === 403) return new AppError("forbidden")
  if (response.status === 404) return new AppError("not-found")
  if (response.status === 400) return new AppError("validation", { form: await messageOf(response) })
  return new AppError("unavailable")
}

export function createStrapiClient({
  baseUrl,
  apiToken,
  fetchImpl = fetch,
}: {
  baseUrl: string
  apiToken: string
  fetchImpl?: typeof fetch
}): StrapiClient {
  const call = async <T>(path: string, method: string, json: unknown, auth: Auth | undefined): Promise<T> => {
    const response = await strapiSend(fetchImpl, baseUrl, path, {
      method,
      headers: { Authorization: `Bearer ${auth?.token ?? apiToken}` },
      json,
    })
    if (!response.ok) throw await failure(response)
    return (await response.json()) as T
  }

  return {
    get(path, query = {}, auth) {
      const search = toQuery(query)
      return call(search ? `${path}?${search}` : path, "GET", undefined, auth)
    },
    send: (method, path, body, auth) => call(path, method, body, auth),
  }
}
