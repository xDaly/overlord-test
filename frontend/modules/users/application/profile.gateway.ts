import type { AuthUser } from "@/modules/auth/domain/session"

export type ProfileUpdate = { displayName: string; bio: string; interests: string[] }

export interface ProfileGateway {
  update(token: string, input: ProfileUpdate): Promise<AuthUser>
  uploadAvatar(token: string, file: Blob, filename: string): Promise<AuthUser>
  removeAvatar(token: string): Promise<AuthUser>
}
