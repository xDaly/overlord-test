import { NextResponse, type NextRequest } from "next/server"

import { AppError } from "@/lib/errors"
import {
  ACCESS_COOKIE,
  REFRESH_COOKIE,
  REFRESH_MAX_AGE,
  accessMaxAge,
  needsRefresh,
  type AuthTokens,
} from "@/modules/auth/domain/session"
import { authGateway } from "@/modules/auth/infrastructure/auth.container"

const COOKIE_OPTIONS = {
  httpOnly: true,
  sameSite: "lax",
  secure: process.env.NODE_ENV === "production",
  path: "/",
} as const

type Renewal = { status: "renewed"; tokens: AuthTokens } | { status: "revoked" } | { status: "unavailable" }

const inflight = new Map<string, Promise<Renewal>>()

function renew(refreshToken: string): Promise<Renewal> {
  const pending = inflight.get(refreshToken)
  if (pending) return pending
  const exchange = authGateway()
    .refresh(refreshToken)
    .then((tokens): Renewal => ({ status: "renewed", tokens }))
    .catch((error): Renewal => ({ status: error instanceof AppError && error.code === "unauthenticated" ? "revoked" : "unavailable" }))
    .finally(() => setTimeout(() => inflight.delete(refreshToken), 5_000))
  inflight.set(refreshToken, exchange)
  return exchange
}

export async function proxy(request: NextRequest) {
  const isPrefetch = request.headers.get("next-router-prefetch") || request.headers.get("purpose") === "prefetch"
  const refreshToken = request.cookies.get(REFRESH_COOKIE)?.value
  if (isPrefetch || !refreshToken || !needsRefresh(request.cookies.get(ACCESS_COOKIE)?.value, Date.now())) {
    return NextResponse.next()
  }

  const renewal = await renew(refreshToken)
  if (renewal.status === "unavailable") return NextResponse.next()

  if (renewal.status === "revoked") {
    request.cookies.delete(ACCESS_COOKIE)
    request.cookies.delete(REFRESH_COOKIE)
    const response = NextResponse.next({ request: { headers: request.headers } })
    response.cookies.delete(ACCESS_COOKIE)
    response.cookies.delete(REFRESH_COOKIE)
    return response
  }

  const { accessToken, refreshToken: nextRefresh } = renewal.tokens
  request.cookies.set(ACCESS_COOKIE, accessToken)
  request.cookies.set(REFRESH_COOKIE, nextRefresh)
  const response = NextResponse.next({ request: { headers: request.headers } })
  response.cookies.set(ACCESS_COOKIE, accessToken, { ...COOKIE_OPTIONS, maxAge: accessMaxAge(accessToken, Date.now()) })
  response.cookies.set(REFRESH_COOKIE, nextRefresh, { ...COOKIE_OPTIONS, maxAge: REFRESH_MAX_AGE })
  return response
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico|.*\\.(?:png|jpg|jpeg|gif|svg|webp|ico)$).*)"],
}
