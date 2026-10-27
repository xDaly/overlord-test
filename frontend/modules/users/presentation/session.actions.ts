"use server"

import { revalidatePath } from "next/cache"

import { AppError } from "@/lib/errors"
import { getAccessToken } from "@/modules/auth/presentation/session"
import { run, type ActionResult } from "@/modules/community/presentation/action-result"
import { getSessionUser } from "@/modules/community/presentation/session"
import { changeMyAvatar, removeMyAvatar, updateMyProfile } from "../application/profile-use-cases"
import type { ProfileInput } from "../domain/profile"
import { profileGateway } from "../infrastructure/profile.container"

async function signedInMember() {
  const [user, token] = await Promise.all([getSessionUser(), getAccessToken()])
  if (!user || !token) throw new AppError("unauthenticated")
  return { token, hadPhoto: Boolean(user.photo) }
}

export async function updateProfileAction(input: ProfileInput): Promise<ActionResult> {
  const result = await run(async () => {
    const { token } = await signedInMember()
    await updateMyProfile(profileGateway(), { token, input })
    return { data: undefined, effects: [{ kind: "message", icon: "check", text: "Profil enregistré" } as const] }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}

export async function uploadAvatarAction(form: FormData): Promise<ActionResult> {
  const result = await run(async () => {
    const { token } = await signedInMember()
    const sent = form.get("file")
    const file = sent instanceof File ? { blob: sent, name: sent.name, type: sent.type, size: sent.size } : undefined
    if (!file) throw new AppError("validation", { photo: "photo.required" })
    await changeMyAvatar(profileGateway(), { token, file })
    return {
      data: undefined,
      effects: [{ kind: "message", icon: "camera", text: "Photo de profil mise à jour" } as const],
    }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}

export async function removeAvatarAction(): Promise<ActionResult> {
  const result = await run(async () => {
    const { token, hadPhoto } = await signedInMember()
    await removeMyAvatar(profileGateway(), { token })
    return {
      data: undefined,
      effects: [{ kind: "message", icon: "camera", text: hadPhoto ? "Photo retirée" : "Aucune modification" } as const],
    }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}
