import { describe, expect, it, vi } from "vitest"

import type { AuthUser } from "@/modules/auth/domain/session"
import { AVATAR_MAX_BYTES } from "../domain/profile"
import type { ProfileGateway } from "./profile.gateway"
import { changeMyAvatar, removeMyAvatar, updateMyProfile } from "./profile-use-cases"

const account: AuthUser = { id: 1, username: "Camille_B", email: "camille@exemple.fr", displayName: "Camille", bio: "", interests: [] }

const makeGateway = (): ProfileGateway => ({
  update: vi.fn(async () => account),
  uploadAvatar: vi.fn(async () => account),
  removeAvatar: vi.fn(async () => account),
})

describe("profile use cases", () => {
  describe("updateMyProfile", () => {
    const input = { pseudo: " Camille  Dubois ", bio: " Bonjour ", interests: ["bourse"] }

    it("saves the cleaned profile in Strapi", async () => {
      const gateway = makeGateway()
      await updateMyProfile(gateway, { token: "t", input })
      expect(gateway.update).toHaveBeenCalledWith("t", { displayName: "Camille Dubois", bio: "Bonjour", interests: ["bourse"] })
    })

    it("never calls Strapi with an invalid profile", async () => {
      const gateway = makeGateway()
      await expect(updateMyProfile(gateway, { token: "t", input: { ...input, pseudo: "Al" } })).rejects.toMatchObject({
        code: "validation",
        fields: { pseudo: "pseudo.tooShort" },
      })
      expect(gateway.update).not.toHaveBeenCalled()
    })
  })

  describe("changeMyAvatar", () => {
    const file = { blob: new Blob(["png"], { type: "image/png" }), name: "avatar.png", type: "image/png", size: 3 }

    it("uploads the image to Strapi", async () => {
      const gateway = makeGateway()
      await changeMyAvatar(gateway, { token: "t", file })
      expect(gateway.uploadAvatar).toHaveBeenCalledWith("t", file.blob, "avatar.png")
    })

    it("never uploads an unsupported or oversized file", async () => {
      const gateway = makeGateway()
      await expect(changeMyAvatar(gateway, { token: "t", file: { ...file, type: "image/svg+xml" } })).rejects.toMatchObject({
        fields: { photo: "photo.invalidType" },
      })
      await expect(changeMyAvatar(gateway, { token: "t", file: { ...file, size: AVATAR_MAX_BYTES + 1 } })).rejects.toMatchObject({
        fields: { photo: "photo.tooLarge" },
      })
      expect(gateway.uploadAvatar).not.toHaveBeenCalled()
    })
  })

  describe("removeMyAvatar", () => {
    it("removes the avatar in Strapi", async () => {
      const gateway = makeGateway()
      await removeMyAvatar(gateway, { token: "t" })
      expect(gateway.removeAvatar).toHaveBeenCalledWith("t")
    })
  })
})
