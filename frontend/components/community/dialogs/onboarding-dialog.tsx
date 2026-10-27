"use client"

import { useState, useTransition } from "react"

import { Button } from "@/components/ui/button"
import { Checkbox } from "@/components/ui/checkbox"
import { Dialog, DialogContent, DialogFooter } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { PROFILE_FALLBACK, profileMessage } from "@/modules/users/presentation/messages"
import { updateProfileAction } from "@/modules/users/presentation/session.actions"
import { CategoryIcon } from "../category-icon"
import { useCommunity } from "../community-context"
import { useEffects } from "../effects"
import { FIELD_HINT, FIELD_LABEL, FieldError, ModalBody, ModalHead, Steps } from "../modal-parts"
import { NotePin } from "../notes"

export function OnboardingDialog({
  open,
  edit,
  onOpenChange,
  onDone,
}: {
  open: boolean
  edit: boolean
  onOpenChange: (open: boolean) => void
  onDone: () => void
}) {
  const { user } = useCommunity()
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        {open ? <OnboardingForm key={user?.username ?? "anonymous"} edit={edit} onDone={onDone} /> : null}
      </DialogContent>
    </Dialog>
  )
}

function OnboardingForm({ edit, onDone }: { edit: boolean; onDone: () => void }) {
  const { user, categories } = useCommunity()
  const { showEffects } = useEffects()
  const [pseudo, setPseudo] = useState(user?.name ?? "")
  const [interests, setInterests] = useState<string[]>(user?.interests ?? [])
  const [bio, setBio] = useState(user?.bio ?? "")
  const [error, setError] = useState<string>()
  const [isPending, startTransition] = useTransition()

  const toggle = (slug: string, checked: boolean) =>
    setInterests((current) => (checked ? [...current, slug] : current.filter((entry) => entry !== slug)))

  const handleSubmit = () =>
    startTransition(async () => {
      const input = { pseudo, interests, bio }
      const result = await updateProfileAction(input)
      if (!result.ok) return setError(profileMessage(result.fields) ?? PROFILE_FALLBACK)
      showEffects(result.effects)
      onDone()
    })

  return (
    <form
      noValidate
      onSubmit={(event) => {
        event.preventDefault()
        handleSubmit()
      }}
    >
      <ModalHead
        title={edit ? "Modifier mon profil" : "Qu'est-ce qui vous intéresse ?"}
        description="Pseudo, centres d'intérêt et présentation"
        pin={<NotePin k="onboarding" />}
      />
      <ModalBody>
        {edit ? null : (
          <>
            <Steps done={2} />
            <p className="text-ink-3">
              Choisissez au moins un sujet : votre fil « Pour vous » sera composé à partir de ces espaces.
            </p>
          </>
        )}
        <div className="flex flex-col gap-1.5">
          <Label htmlFor="ob-name" className={FIELD_LABEL}>
            Votre pseudo
          </Label>
          <Input
            id="ob-name"
            value={pseudo}
            onChange={(event) => {
              setPseudo(event.target.value)
              setError(undefined)
            }}
            maxLength={24}
            autoComplete="off"
            placeholder="Ex. : EpargnantDuNord"
            aria-invalid={Boolean(error)}
            aria-describedby="ob-name-hint"
          />
          {error ? <FieldError id="ob-name-hint" message={error} /> : null}
          <span id="ob-name-hint" className={FIELD_HINT}>
            {user
              ? `Votre identifiant pour les mentions reste @${user.username}.`
              : "Un pseudonyme suffit : votre nom n'est jamais affiché."}
          </span>
        </div>
        <div className="grid grid-cols-2 gap-2 max-[760px]:grid-cols-1">
          {categories.map((category) => (
            <Label
              key={category.slug}
              className="flex cursor-pointer items-center gap-2.5 rounded-[9px] border-[1.5px] border-line px-3 py-[11px] text-sm font-medium has-data-checked:border-brand has-data-checked:bg-brand-soft has-focus-visible:outline-2 has-focus-visible:outline-brand"
            >
              <CategoryIcon category={category} />
              {category.name}
              <Checkbox
                checked={interests.includes(category.slug)}
                onCheckedChange={(checked) => toggle(category.slug, Boolean(checked))}
                className="ml-auto size-[18px] rounded-full border-[1.5px] border-line-strong data-checked:border-brand data-checked:bg-brand data-checked:text-white"
              />
            </Label>
          ))}
        </div>
        <div className="flex flex-col gap-1.5">
          <Label htmlFor="ob-bio" className={FIELD_LABEL}>
            Présentez-vous en une phrase <span className="font-normal text-ink-3">(facultatif)</span>
          </Label>
          <Input
            id="ob-bio"
            value={bio}
            onChange={(event) => setBio(event.target.value)}
            maxLength={280}
            placeholder="Ex. : 35 ans, je prépare l'achat de ma résidence principale"
          />
        </div>
      </ModalBody>
      <DialogFooter>
        <span className={FIELD_HINT}>{edit ? "" : "Modifiable à tout moment depuis votre profil"}</span>
        <Button type="submit" disabled={isPending}>
          {edit ? "Enregistrer" : "C'est parti"}
        </Button>
      </DialogFooter>
    </form>
  )
}
