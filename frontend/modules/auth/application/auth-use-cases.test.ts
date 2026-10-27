import { describe, expect, it, vi } from "vitest"

import type { AuthSession } from "../domain/session"
import type { AuthGateway } from "./auth.gateway"
import { login } from "./login.use-case"
import { register } from "./register.use-case"

const session: AuthSession = {
  user: { id: 1, username: "alex", email: "alex@exemple.fr", displayName: "Alex", bio: "", interests: [] },
  tokens: { accessToken: "access", refreshToken: "refresh" },
}

const makeGateway = (): AuthGateway => ({
  login: vi.fn(async () => session),
  register: vi.fn(async () => session),
  refresh: vi.fn(),
  me: vi.fn(),
  logout: vi.fn(),
})

describe("login", () => {
  it("sends the cleaned credentials to the gateway", async () => {
    const gateway = makeGateway()
    await expect(login(gateway, { identifier: " alex@exemple.fr ", password: "secret" })).resolves.toBe(session)
    expect(gateway.login).toHaveBeenCalledWith("alex@exemple.fr", "secret")
  })

  it("never calls the gateway with invalid input", async () => {
    const gateway = makeGateway()
    await expect(login(gateway, { identifier: "", password: "" })).rejects.toMatchObject({ code: "validation" })
    expect(gateway.login).not.toHaveBeenCalled()
  })
})

describe("register", () => {
  const input = { username: "Alex_75", email: "Alex@Exemple.fr", password: "motdepasse1" }

  it("registers with a display name equal to the username", async () => {
    const gateway = makeGateway()
    await expect(register(gateway, input)).resolves.toBe(session)
    expect(gateway.register).toHaveBeenCalledWith({
      username: "Alex_75",
      email: "alex@exemple.fr",
      password: "motdepasse1",
      displayName: "Alex_75",
    })
  })

  it("never calls the gateway with invalid input", async () => {
    const gateway = makeGateway()
    await expect(register(gateway, { ...input, password: "court" })).rejects.toMatchObject({
      code: "validation",
      fields: { password: "password.tooShort" },
    })
    expect(gateway.register).not.toHaveBeenCalled()
  })
})
