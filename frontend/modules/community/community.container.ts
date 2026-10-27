import { cache } from "react"

import { strapiPublicUrl } from "@/modules/auth/infrastructure/auth.container"
import { getAccessToken, getAuthUser } from "@/modules/auth/presentation/session"
import { StrapiBlogRepository } from "@/modules/blogs/infrastructure/strapi-blog.repository"
import { listCategories } from "@/modules/categories/categories.container"
import { StrapiDiscussionRepository, type Viewer } from "@/modules/discussions/infrastructure/strapi-discussion.repository"
import { StrapiEventRepository } from "@/modules/events/infrastructure/strapi-event.repository"
import { StrapiNotificationRepository } from "@/modules/notifications/infrastructure/strapi-notification.repository"
import type { UserRepository } from "@/modules/users/application/user.repository"
import { StrapiUserRepository } from "@/modules/users/infrastructure/strapi-user.repository"
import type { CommunityDeps } from "./application/deps"
import { serverStrapiClient } from "./infrastructure/strapi-server-client"

const currentViewer = cache(async (): Promise<Viewer | null> => {
  const [account, token] = await Promise.all([getAuthUser(), getAccessToken()])
  return account && token ? { id: account.id, username: account.username, token } : null
})

function build(): CommunityDeps {
  const client = serverStrapiClient()
  const members = new StrapiUserRepository({ client, publicUrl: strapiPublicUrl() })
  const listMembers = cache(() => members.list())
  const users: UserRepository = {
    list: listMembers,
    findByUsername: async (username) => (await listMembers()).find((user) => user.username === username) ?? null,
  }
  const shared = { client, users, viewer: currentViewer, categories: listCategories }
  return {
    discussions: new StrapiDiscussionRepository(shared),
    blogs: new StrapiBlogRepository(shared),
    events: new StrapiEventRepository({ client, viewer: currentViewer }),
    users,
    notifications: new StrapiNotificationRepository({ client, viewer: currentViewer }),
  }
}

const registry = globalThis as unknown as { communityRuntime?: CommunityDeps }

export const community = (): CommunityDeps => (registry.communityRuntime ??= build())
