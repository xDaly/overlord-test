import { parseRegistration } from "../domain/credentials"
import type { AuthSession } from "../domain/session"
import type { AuthGateway } from "./auth.gateway"

export async function register(gateway: AuthGateway, input: unknown): Promise<AuthSession> {
  const account = parseRegistration(input)
  return gateway.register({ ...account, displayName: account.username })
}
