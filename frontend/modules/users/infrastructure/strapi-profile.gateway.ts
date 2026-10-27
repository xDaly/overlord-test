import { API_ROUTES } from "@/lib/api-routes"
import { AppError, type FieldErrors } from "@/lib/errors"
import { strapiSend, type StrapiRequest } from "@/lib/strapi-send"
import { toAuthUser, type StrapiUser } from "@/modules/auth/infrastructure/strapi-user"
import type { ProfileGateway } from "../application/profile.gateway"

export function createStrapiProfileGateway(
  baseUrl: string,
  publicUrl: string = baseUrl,
  fetchImpl: typeof fetch = fetch
): ProfileGateway {
  const call = async (token: string, path: string, request: StrapiRequest, refusal: FieldErrors) => {
    const response = await strapiSend(fetchImpl, baseUrl, path, {
      ...request,
      headers: { ...request.headers, Authorization: `Bearer ${token}` },
    })
    if (response.ok) return toAuthUser((await response.json()) as StrapiUser, publicUrl)
    if (response.status === 400) throw new AppError("validation", refusal)
    if (response.status === 413) throw new AppError("validation", { photo: "photo.tooLarge" })
    if (response.status === 401 || response.status === 403) throw new AppError("unauthenticated")
    throw new AppError("unavailable")
  }

  return {
    update: (token, input) => call(token, API_ROUTES.users.me, { method: "PUT", json: input }, { form: "profile.invalid" }),

    uploadAvatar(token, file, filename) {
      const form = new FormData()
      form.append("files", file, filename)
      return call(token, API_ROUTES.users.avatar, { method: "POST", form }, { photo: "photo.rejected" })
    },

    removeAvatar: (token) => call(token, API_ROUTES.users.avatar, { method: "DELETE" }, { form: "profile.invalid" }),
  }
}
