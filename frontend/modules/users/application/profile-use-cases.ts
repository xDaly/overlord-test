import { assertAvatar, parseProfile, type ProfileInput } from "../domain/profile"
import type { ProfileGateway } from "./profile.gateway"

type Member = { token: string }

export type AvatarFile = { blob: Blob; name: string; type: string; size: number }

export async function updateMyProfile(gateway: ProfileGateway, { token, input }: Member & { input: ProfileInput }): Promise<void> {
  const profile = parseProfile(input)
  await gateway.update(token, { displayName: profile.pseudo, bio: profile.bio, interests: profile.interests })
}

export async function changeMyAvatar(gateway: ProfileGateway, { token, file }: Member & { file: AvatarFile }): Promise<void> {
  assertAvatar(file)
  await gateway.uploadAvatar(token, file.blob, file.name)
}

export async function removeMyAvatar(gateway: ProfileGateway, { token }: Member): Promise<void> {
  await gateway.removeAvatar(token)
}
