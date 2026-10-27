"use client"

import { Camera } from "lucide-react"
import { useEffect, useRef, useState, useTransition } from "react"

import { Button } from "@/components/ui/button"
import { Dialog, DialogContent, DialogFooter } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { PROFILE_FALLBACK, profileMessage } from "@/modules/users/presentation/messages"
import { removeAvatarAction, uploadAvatarAction } from "@/modules/users/presentation/session.actions"
import { useCommunity } from "../community-context"
import { useEffects } from "../effects"
import { FIELD_HINT, FieldError, ModalBody, ModalHead } from "../modal-parts"
import { NotePin } from "../notes"
import { UserAvatar } from "../user-avatar"

const SIDE = 256
const QUALITY = 0.86

function squarePhoto(file: File): Promise<Blob> {
  return new Promise((resolve, reject) => {
    const image = new Image()
    const source = URL.createObjectURL(file)
    image.onload = () => {
      const side = Math.min(image.width, image.height)
      const canvas = document.createElement("canvas")
      canvas.width = canvas.height = SIDE
      canvas.getContext("2d")?.drawImage(image, (image.width - side) / 2, (image.height - side) / 2, side, side, 0, 0, SIDE, SIDE)
      URL.revokeObjectURL(source)
      canvas.toBlob((blob) => (blob ? resolve(blob) : reject(new Error("image illisible"))), "image/jpeg", QUALITY)
    }
    image.onerror = () => {
      URL.revokeObjectURL(source)
      reject(new Error("image illisible"))
    }
    image.src = source
  })
}

export function PhotoDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[440px]">
        {open ? <PhotoForm onClose={() => onOpenChange(false)} /> : null}
      </DialogContent>
    </Dialog>
  )
}

function PhotoForm({ onClose }: { onClose: () => void }) {
  const { user } = useCommunity()
  const { showEffects, showMessage } = useEffects()
  const input = useRef<HTMLInputElement>(null)
  const [preview, setPreview] = useState<string | null>(user?.photo ?? null)
  const [file, setFile] = useState<File | null>(null)
  const [error, setError] = useState<string>()
  const [isPending, startTransition] = useTransition()

  useEffect(() => () => void (preview?.startsWith("blob:") && URL.revokeObjectURL(preview)), [preview])

  if (!user) return null

  const handleFile = async (picked: File | undefined) => {
    if (!picked) return
    try {
      const blob = await squarePhoto(picked)
      setFile(new File([blob], "avatar.jpg", { type: "image/jpeg" }))
      setPreview(URL.createObjectURL(blob))
      setError(undefined)
    } catch {
      showMessage("camera", "Cette image n'a pas pu être lue. Essayez un fichier JPG ou PNG.")
    }
  }

  const handleRemove = () => {
    setFile(null)
    setPreview(null)
    setError(undefined)
  }

  const handleSave = () =>
    startTransition(async () => {
      if (!file && (preview || !user.photo)) return onClose()
      const form = new FormData()
      if (file) form.set("file", file)
      const result = file ? await uploadAvatarAction(form) : await removeAvatarAction()
      if (!result.ok) return setError(profileMessage(result.fields) ?? PROFILE_FALLBACK)
      showEffects(result.effects)
      onClose()
    })

  return (
    <form
      onSubmit={(event) => {
        event.preventDefault()
        handleSave()
      }}
    >
      <ModalHead title="Photo de profil" description="Choisir ou retirer votre photo" pin={<NotePin k="photo" />} />
      <ModalBody className="items-center">
        <UserAvatar user={{ ...user, photo: preview ?? undefined }} size="xl" className="size-[120px] text-[40px]" />
        <p className="text-center text-ink-3">
          Une photo rend vos échanges plus personnels. Elle est visible par tous les membres.
        </p>
        <div className="flex flex-wrap justify-center gap-2">
          <Button type="button" variant="secondary" onClick={() => input.current?.click()}>
            <Camera />
            Choisir une image…
          </Button>
          <Input
            ref={input}
            type="file"
            accept="image/jpeg,image/png,image/webp"
            className="sr-only"
            tabIndex={-1}
            aria-label="Choisir une image"
            onChange={(event) => {
              void handleFile(event.target.files?.[0])
              event.target.value = ""
            }}
          />
          {preview ? (
            <Button type="button" variant="ghost" onClick={handleRemove}>
              Retirer la photo
            </Button>
          ) : null}
        </div>
        <FieldError id="photo-error" message={error} />
        <p className={`${FIELD_HINT} text-center`}>JPG, PNG ou WebP · recadrée automatiquement</p>
      </ModalBody>
      <DialogFooter>
        <Button type="button" variant="ghost" onClick={onClose}>
          Annuler
        </Button>
        <Button type="submit" disabled={isPending}>
          Enregistrer
        </Button>
      </DialogFooter>
    </form>
  )
}
