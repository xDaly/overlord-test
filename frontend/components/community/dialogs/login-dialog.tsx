"use client"

import { Check } from "lucide-react"
import { useRouter } from "next/navigation"
import { useState, useTransition } from "react"

import { Button } from "@/components/ui/button"
import { Dialog, DialogContent } from "@/components/ui/dialog"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { loginAction, registerAction } from "@/modules/auth/presentation/auth.actions"
import { UNAVAILABLE_MESSAGE, authMessage } from "@/modules/auth/presentation/messages"
import { useEffects } from "../effects"
import { FIELD_HINT, FIELD_LABEL, FieldError, ModalBody, ModalHead, Steps } from "../modal-parts"
import { NotePin } from "../notes"

const BENEFITS = [
  "Posez vos questions d'argent aux lecteurs et à la rédaction",
  "Suivez les discussions qui vous concernent",
  "Gagnez des badges en aidant les autres",
]

type Mode = "login" | "register"
type Errors = Record<string, string>

export function LoginDialog({
  open,
  onOpenChange,
  onRegistered,
}: {
  open: boolean
  onOpenChange: (open: boolean) => void
  onRegistered: () => void
}) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[440px]">
        {open ? <AuthForm onClose={() => onOpenChange(false)} onRegistered={onRegistered} /> : null}
      </DialogContent>
    </Dialog>
  )
}

function AuthForm({ onClose, onRegistered }: { onClose: () => void; onRegistered: () => void }) {
  const router = useRouter()
  const { showEffects } = useEffects()
  const [mode, setMode] = useState<Mode>("login")
  const [identifier, setIdentifier] = useState("")
  const [email, setEmail] = useState("")
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [errors, setErrors] = useState<Errors>({})
  const [isPending, startTransition] = useTransition()
  const register = mode === "register"

  const switchMode = () => {
    setMode(register ? "login" : "register")
    setErrors({})
  }

  const clear = (field: string) =>
    setErrors((current) => {
      const next = { ...current }
      delete next[field]
      delete next.form
      return next
    })

  const handleSubmit = () =>
    startTransition(async () => {
      const result = register
        ? await registerAction({ username, email, password })
        : await loginAction({ identifier, password })
      if (!result.ok) {
        const known = Object.fromEntries(Object.entries(result.fields).map(([field, code]) => [field, authMessage(code) ?? code]))
        return setErrors(
          Object.keys(known).length > 0
            ? known
            : { form: result.error === "unavailable" ? UNAVAILABLE_MESSAGE : "La demande a échoué. Réessayez." }
        )
      }
      showEffects(result.effects)
      if (register) return onRegistered()
      onClose()
      router.refresh()
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
        title={register ? "Rejoindre la communauté" : "Se connecter"}
        description={register ? "Créez votre compte gratuit" : "Retrouvez vos discussions et vos notifications"}
        pin={<NotePin k="onboarding" />}
      />
      <ModalBody>
        {register ? (
          <>
            <Steps done={1} />
            <ul className="flex flex-col gap-[7px] text-sm text-ink-2">
              {BENEFITS.map((benefit) => (
                <li key={benefit} className="flex gap-2">
                  <Check className="mt-0.5 size-4 shrink-0 text-ok" />
                  {benefit}
                </li>
              ))}
            </ul>
          </>
        ) : null}
        {register ? (
          <>
            <Field id="au-mail" label="Adresse e-mail" error={errors.email}>
              <Input
                id="au-mail"
                type="email"
                value={email}
                onChange={(event) => {
                  setEmail(event.target.value)
                  clear("email")
                }}
                autoComplete="email"
                aria-invalid={Boolean(errors.email)}
                aria-describedby="au-mail-error"
                autoFocus
              />
            </Field>
            <Field id="au-user" label="Identifiant" error={errors.username} hint="Il s'affiche sous la forme @identifiant et ne change plus ensuite.">
              <Input
                id="au-user"
                value={username}
                onChange={(event) => {
                  setUsername(event.target.value)
                  clear("username")
                }}
                maxLength={24}
                autoComplete="username"
                placeholder="Ex. : EpargnantDuNord"
                aria-invalid={Boolean(errors.username)}
                aria-describedby="au-user-error"
              />
            </Field>
          </>
        ) : (
          <Field id="au-id" label="Adresse e-mail ou identifiant" error={errors.identifier}>
            <Input
              id="au-id"
              value={identifier}
              onChange={(event) => {
                setIdentifier(event.target.value)
                clear("identifier")
              }}
              autoComplete="username"
              aria-invalid={Boolean(errors.identifier)}
              aria-describedby="au-id-error"
              autoFocus
            />
          </Field>
        )}
        <Field
          id="au-pw"
          label="Mot de passe"
          error={errors.password}
          hint={register ? "8 caractères minimum, avec au moins une lettre et un chiffre." : undefined}
        >
          <Input
            id="au-pw"
            type="password"
            value={password}
            onChange={(event) => {
              setPassword(event.target.value)
              clear("password")
            }}
            autoComplete={register ? "new-password" : "current-password"}
            aria-invalid={Boolean(errors.password)}
            aria-describedby="au-pw-error"
          />
        </Field>
        <FieldError id="au-form-error" message={errors.form} />
        <Button type="submit" className="w-full" disabled={isPending}>
          {register ? "Créer mon compte" : "Se connecter"}
        </Button>
        <p className={`${FIELD_HINT} text-center`}>
          {register ? "Déjà un compte ?" : "Pas encore de compte ?"}{" "}
          <Button type="button" variant="link" className="h-auto p-0 text-[12.5px] font-semibold" onClick={switchMode}>
            {register ? "Se connecter" : "Créer un compte gratuit"}
          </Button>
        </p>
      </ModalBody>
    </form>
  )
}

function Field({
  id,
  label,
  error,
  hint,
  children,
}: {
  id: string
  label: string
  error?: string
  hint?: string
  children: React.ReactNode
}) {
  return (
    <div className="flex flex-col gap-1.5">
      <Label htmlFor={id} className={FIELD_LABEL}>
        {label}
      </Label>
      {children}
      <FieldError id={`${id}-error`} message={error} />
      {hint && !error ? <span className={FIELD_HINT}>{hint}</span> : null}
    </div>
  )
}
