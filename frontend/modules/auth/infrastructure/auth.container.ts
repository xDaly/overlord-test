import type { AuthGateway } from "../application/auth.gateway"
import { createStrapiAuthGateway } from "./strapi-auth.gateway"

const DEFAULT_STRAPI_URL = "http://localhost:1337"

export const strapiUrl = () => process.env.STRAPI_URL ?? DEFAULT_STRAPI_URL

export const strapiPublicUrl = () => process.env.STRAPI_PUBLIC_URL ?? strapiUrl()

export const authGateway = (): AuthGateway => createStrapiAuthGateway(strapiUrl(), fetch, strapiPublicUrl())
