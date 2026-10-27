import { createStrapiClient, type StrapiClient } from "@/lib/strapi-client"
import { strapiUrl } from "@/modules/auth/infrastructure/auth.container"

export function serverStrapiClient(): StrapiClient {
  const apiToken = process.env.STRAPI_API_TOKEN
  if (!apiToken) throw new Error("STRAPI_API_TOKEN est manquant dans le fichier .env à la racine : lancez `npm run seed -w strapi`, qui crée le jeton et l'y écrit.")
  return createStrapiClient({ baseUrl: strapiUrl(), apiToken })
}
