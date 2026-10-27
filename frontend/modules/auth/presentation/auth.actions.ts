"use server"

import { revalidatePath } from "next/cache"

import { run, type ActionResult } from "@/modules/community/presentation/action-result"
import { login } from "../application/login.use-case"
import { register } from "../application/register.use-case"
import { authGateway } from "../infrastructure/auth.container"
import { clearTokens, readTokens, writeTokens } from "./session-cookies"

export async function loginAction(input: { identifier: string; password: string }): Promise<ActionResult> {
  const result = await run(async () => {
    const session = await login(authGateway(), input)
    await writeTokens(session.tokens)
    return {
      data: undefined,
      effects: [
        { kind: "message", icon: "user", title: `Bon retour, ${session.user.displayName}`, text: "Vous êtes connecté." } as const,
      ],
    }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}

export async function registerAction(input: {
  username: string
  email: string
  password: string
}): Promise<ActionResult> {
  return run(async () => {
    const session = await register(authGateway(), input)
    await writeTokens(session.tokens)
    return { data: undefined, effects: session.welcome ?? [] }
  })
}

export async function logoutAction(): Promise<void> {
  const { accessToken, refreshToken } = await readTokens()
  if (accessToken && refreshToken) await authGateway().logout({ accessToken, refreshToken })
  await clearTokens()
  revalidatePath("/", "layout")
}
