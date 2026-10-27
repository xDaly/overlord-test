"use client"

import { useRouter } from "next/navigation"
import { createContext, useCallback, useContext, useEffect, useMemo, useRef, useState, type ReactNode } from "react"

import type { UiEffect } from "@/modules/community/presentation/action-result"
import { useCommunity } from "../community-context"
import { useEffects } from "../effects"
import { BlogDialog } from "./blog-dialog"
import { ComposerDialog, type ComposerOptions } from "./composer-dialog"
import { LoginDialog } from "./login-dialog"
import { OnboardingDialog } from "./onboarding-dialog"
import { PhotoDialog } from "./photo-dialog"
import { ReportDialog } from "./report-dialog"

type Dialog = "login" | "onboarding" | "profile" | "composer" | "blog" | "photo" | "report" | null

type Dialogs = {
  openLogin: () => void
  openComposer: (options?: ComposerOptions) => void
  openBlogEditor: () => void
  openPhoto: () => void
  openReport: () => void
  openProfileEditor: () => void
  requireLogin: (action: () => void) => void
}

const Context = createContext<Dialogs | null>(null)

export function useDialogs(): Dialogs {
  const context = useContext(Context)
  if (!context) throw new Error("useDialogs doit être utilisé dans DialogsProvider")
  return context
}

const RESUME_DELAY = 400

export function DialogsProvider({ children }: { children: ReactNode }) {
  const router = useRouter()
  const { user } = useCommunity()
  const { showEffects, showMessage } = useEffects()
  const [dialog, setDialog] = useState<Dialog>(null)
  const [composerOptions, setComposerOptions] = useState<ComposerOptions>({})
  const pending = useRef<(() => void) | null>(null)

  useEffect(() => {
    if (!user || !pending.current || dialog === "login" || dialog === "onboarding") return
    const resume = pending.current
    pending.current = null
    const id = setTimeout(resume, RESUME_DELAY)
    return () => clearTimeout(id)
  }, [user, dialog])

  const userRef = useRef(user)
  useEffect(() => {
    userRef.current = user
  }, [user])

  const openLogin = useCallback(() => setDialog("login"), [])

  const requireLogin = useCallback(
    (action: () => void) => {
      if (userRef.current) return action()
      pending.current = action
      setDialog("login")
    },
    []
  )

  const openComposer = useCallback(
    (options: ComposerOptions = {}) =>
      requireLogin(() => {
        setComposerOptions(options)
        setDialog("composer")
      }),
    [requireLogin]
  )
  const openBlogEditor = useCallback(() => requireLogin(() => setDialog("blog")), [requireLogin])
  const openPhoto = useCallback(() => requireLogin(() => setDialog("photo")), [requireLogin])
  const openReport = useCallback(() => requireLogin(() => setDialog("report")), [requireLogin])
  const openProfileEditor = useCallback(() => setDialog("profile"), [])

  const handleDiscussionCreated = useCallback(
    ({ id, effects }: { id: string; effects: UiEffect[] }) => {
      setDialog(null)
      router.push(`/discussions/${id}`)
      showEffects(effects)
      showMessage("bell", "Vous serez notifié dès qu'un membre répond.", "Vous suivez cette discussion")
    },
    [router, showEffects, showMessage]
  )

  const handleBlogCreated = useCallback(
    ({ id, effects }: { id: string; effects: UiEffect[] }) => {
      setDialog(null)
      router.push(`/billets/${id}`)
      showEffects(effects)
    },
    [router, showEffects]
  )

  const handleRegistered = useCallback(() => {
    setDialog(null)
    router.refresh()
  }, [router])

  const value = useMemo(
    () => ({ openLogin, openComposer, openBlogEditor, openPhoto, openReport, openProfileEditor, requireLogin }),
    [openLogin, openComposer, openBlogEditor, openPhoto, openReport, openProfileEditor, requireLogin]
  )

  const close = (name: Exclude<Dialog, null>) => (open: boolean) => {
    if (!open) setDialog((current) => (current === name ? null : current))
  }

  return (
    <Context.Provider value={value}>
      {children}
      <LoginDialog open={dialog === "login"} onOpenChange={close("login")} onRegistered={() => setDialog("onboarding")} />
      <OnboardingDialog
        open={dialog === "onboarding"}
        edit={false}
        onOpenChange={(open) => {
          close("onboarding")(open)
          if (!open) router.refresh()
        }}
        onDone={handleRegistered}
      />
      <OnboardingDialog
        open={dialog === "profile"}
        edit
        onOpenChange={close("profile")}
        onDone={() => {
          setDialog(null)
          router.refresh()
        }}
      />
      <ComposerDialog
        open={dialog === "composer"}
        options={composerOptions}
        onOpenChange={close("composer")}
        onCreated={handleDiscussionCreated}
      />
      <BlogDialog open={dialog === "blog"} onOpenChange={close("blog")} onCreated={handleBlogCreated} />
      <PhotoDialog open={dialog === "photo"} onOpenChange={close("photo")} />
      <ReportDialog open={dialog === "report"} onOpenChange={close("report")} />
    </Context.Provider>
  )
}
