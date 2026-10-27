import type { AuthSession, AuthTokens, AuthUser } from "../domain/session"

export type NewAccount = { username: string; email: string; password: string; displayName: string }

export interface AuthGateway {
  login(identifier: string, password: string): Promise<AuthSession>
  register(account: NewAccount): Promise<AuthSession>
  refresh(refreshToken: string): Promise<AuthTokens>
  me(accessToken: string): Promise<AuthUser | null>
  logout(tokens: AuthTokens): Promise<void>
}
