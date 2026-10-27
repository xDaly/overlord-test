export const API_ROUTES = {
  categories: {
    list: "/api/categories",
    create: "/api/categories",
    detail: (documentId: string) => `/api/categories/${documentId}`,
    bySlug: (slug: string) => `/api/categories/slug/${slug}`,
    discussions: (slug: string) => `/api/categories/slug/${slug}/discussions`,
  },

  discussions: {
    list: "/api/discussions",
    create: "/api/discussions",
    detail: (documentId: string) => `/api/discussions/${documentId}`,
    bySlug: (slug: string) => `/api/discussions/slug/${slug}`,
    search: "/api/discussions/search",
    replies: (documentId: string) => `/api/discussions/${documentId}/replies`,
    useful: (documentId: string) => `/api/discussions/${documentId}/useful`,
    follow: (documentId: string) => `/api/discussions/${documentId}/follow`,
    report: (documentId: string) => `/api/discussions/${documentId}/report`,
    similar: (documentId: string) => `/api/discussions/${documentId}/similar`,
  },

  replies: {
    list: "/api/replies",
    create: "/api/replies",
    detail: (documentId: string) => `/api/replies/${documentId}`,
    useful: (documentId: string) => `/api/replies/${documentId}/useful`,
    bestAnswer: (documentId: string) => `/api/replies/${documentId}/best-answer`,
    report: (documentId: string) => `/api/replies/${documentId}/report`,
  },

  auth: {
    login: "/api/auth/local",
    register: "/api/auth/local/register",
    refresh: "/api/auth/refresh",
    logout: "/api/auth/logout",
    forgotPassword: "/api/auth/forgot-password",
    resetPassword: "/api/auth/reset-password",
    changePassword: "/api/auth/change-password",
    emailConfirmation: "/api/auth/email-confirmation",
    sendEmailConfirmation: "/api/auth/send-email-confirmation",
    providerCallback: (provider: string) => `/api/auth/${provider}/callback`,
    connect: (provider: string) => `/api/connect/${provider}`,
  },

  users: {
    list: "/api/users",
    create: "/api/users",
    count: "/api/users/count",
    me: "/api/users/me",
    avatar: "/api/users/me/avatar",
    detail: (id: number) => `/api/users/${id}`,
    byUsername: (username: string) => `/api/users/username/${username}`,
    discussions: (username: string) => `/api/users/username/${username}/discussions`,
    replies: (username: string) => `/api/users/username/${username}/replies`,
    leaderboard: "/api/users/leaderboard",
  },

  permissions: {
    roles: "/api/users-permissions/roles",
    role: (id: number) => `/api/users-permissions/roles/${id}`,
    list: "/api/users-permissions/permissions",
  },

  upload: {
    create: "/api/upload",
    files: "/api/upload/files",
    file: (id: number) => `/api/upload/files/${id}`,
  },
} as const

export const API_QUERY = {
  pageSize: 10,
  maxPageSize: 100,
  sort: {
    newest: "createdAt:desc",
    oldest: "createdAt:asc",
    title: "title:asc",
  },
  populate: {
    discussionCard: {
      category: { fields: ["name", "slug"] },
      author: { fields: ["username", "displayName"], populate: { avatar: { fields: ["url"] } } },
    },
    discussionDetail: {
      category: { fields: ["name", "slug"] },
      author: { fields: ["username", "displayName", "bio"], populate: { avatar: { fields: ["url"] } } },
      replies: {
        sort: ["createdAt:asc"],
        populate: { author: { fields: ["username", "displayName"], populate: { avatar: { fields: ["url"] } } } },
      },
    },
  },
} as const

export const API_ERROR_STATUS = {
  validation: 400,
  unauthenticated: 401,
  forbidden: 403,
  notFound: 404,
  server: 500,
} as const
