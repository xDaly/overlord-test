import { parseLogin } from "../domain/credentials"
import type { AuthSession } from "../domain/session"
import type { AuthGateway } from "./auth.gateway"

export async function login(gateway: AuthGateway, input: unknown): Promise<AuthSession> {
  const { identifier, password } = parseLogin(input)
  return gateway.login(identifier, password)
}
