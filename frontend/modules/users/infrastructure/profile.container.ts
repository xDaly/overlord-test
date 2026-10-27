import { strapiPublicUrl, strapiUrl } from "@/modules/auth/infrastructure/auth.container"
import type { ProfileGateway } from "../application/profile.gateway"
import { createStrapiProfileGateway } from "./strapi-profile.gateway"

export const profileGateway = (): ProfileGateway => createStrapiProfileGateway(strapiUrl(), strapiPublicUrl())
