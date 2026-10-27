"use client"

import { Bell, BadgeCheck, Check, Flag, Reply, ThumbsUp } from "lucide-react"
import { useRouter } from "next/navigation"
import { useOptimistic, useTransition, type ReactNode } from "react"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import { toggleBlogUsefulAction } from "@/modules/blogs/presentation/blog.actions"
import {
  chooseSolutionAction,
  toggleFollowAction,
  toggleUsefulAction,
  verifyReplyAction,
} from "@/modules/discussions/presentation/discussion.actions"
import { useDialogs } from "./dialogs/dialogs-context"
import { useEffects } from "./effects"

const ACTION = "h-8 gap-1.5 rounded-lg px-[11px] text-[13.5px] font-medium"
const FIRST_LIKE_KEY = "lr-first-like"

type Subject = { kind: "discussion" | "blog"; id: string; replyId?: string }

export function UsefulButton({
  subject,
  likes,
  liked,
  pin,
}: {
  subject: Subject
  likes: number
  liked: boolean
  pin?: ReactNode
}) {
  const router = useRouter()
  const { requireLogin } = useDialogs()
  const { showMessage } = useEffects()
  const [optimistic, setOptimistic] = useOptimistic({ likes, liked }, (_state, next: { likes: number; liked: boolean }) => next)
  const [isPending, startTransition] = useTransition()

  const toggle = () =>
    requireLogin(() =>
      startTransition(async () => {
        setOptimistic({ likes: optimistic.likes + (optimistic.liked ? -1 : 1), liked: !optimistic.liked })
        const result =
          subject.kind === "blog"
            ? await toggleBlogUsefulAction(subject.id, subject.replyId ?? null)
            : await toggleUsefulAction(subject.id, subject.replyId ?? null)
        if (!result.ok) {
          if (result.error === "forbidden")
            showMessage("thumb", "Vous ne pouvez pas marquer votre propre message comme utile.")
        } else if (result.data.liked && result.data.rewardedAuthor) {
          try {
            if (!sessionStorage.getItem(FIRST_LIKE_KEY)) {
              sessionStorage.setItem(FIRST_LIKE_KEY, "1")
              showMessage("thumb", `${result.data.rewardedAuthor} reçoit +5 points grâce à vous.`, "Merci !")
            }
          } catch {
          }
        }
        router.refresh()
      })
    )

  return (
    <>
      <Button
        variant="secondary"
        disabled={isPending}
        aria-pressed={optimistic.liked}
        onClick={toggle}
        className={cn(
          ACTION,
          "font-medium text-ink-2",
          optimistic.liked && "border-transparent bg-brand-soft text-brand-text shadow-none hover:bg-brand-soft"
        )}
      >
        <ThumbsUp className={cn(optimistic.liked && "animate-pop")} />
        Utile <span className="tabular-nums">{optimistic.likes}</span>
      </Button>
      {pin}
    </>
  )
}

export function FollowButton({ discussionId, followed, pin }: { discussionId: string; followed: boolean; pin?: ReactNode }) {
  const router = useRouter()
  const { requireLogin } = useDialogs()
  const { showMessage } = useEffects()
  const [optimistic, setOptimistic] = useOptimistic(followed, (_state, next: boolean) => next)
  const [isPending, startTransition] = useTransition()

  const toggle = () =>
    requireLogin(() =>
      startTransition(async () => {
        setOptimistic(!optimistic)
        const result = await toggleFollowAction(discussionId)
        if (result.ok && result.data.followed)
          showMessage("bell", "Vous serez notifié des nouvelles réponses.", "Discussion suivie")
        else if (result.ok) showMessage("bell", "Vous ne suivez plus cette discussion.")
        router.refresh()
      })
    )

  return (
    <>
      <Button variant="ghost" disabled={isPending} onClick={toggle} className={cn(ACTION, optimistic && "text-brand-text")}>
        <Bell />
        {optimistic ? "Suivie" : "Suivre"}
      </Button>
      {pin}
    </>
  )
}

export function ReportButton({ label = true, pin }: { label?: boolean; pin?: ReactNode }) {
  const { openReport } = useDialogs()
  return (
    <>
      <Button
        variant="ghost"
        aria-label="Signaler"
        onClick={openReport}
        className={cn(ACTION, "ml-auto text-ink-3", !label && "px-2.5")}
      >
        <Flag />
        {label ? "Signaler" : null}
      </Button>
      {pin}
    </>
  )
}

export function ReplyToButton({ username }: { username: string }) {
  const { requireLogin } = useDialogs()
  const insert = () =>
    requireLogin(() => {
      const field = document.getElementById("reply-body") as HTMLTextAreaElement | null
      if (!field) return
      field.value = `${field.value ? `${field.value} ` : ""}@${username} `
      field.dispatchEvent(new Event("input", { bubbles: true }))
      field.focus()
      field.scrollIntoView({ behavior: "smooth", block: "center" })
    })
  return (
    <Button variant="ghost" onClick={insert} className={ACTION}>
      <Reply />
      Répondre
    </Button>
  )
}

export function SolveButton({ discussionId, replyId, chosen }: { discussionId: string; replyId: string; chosen: boolean }) {
  const router = useRouter()
  const { showEffects } = useEffects()
  const [isPending, startTransition] = useTransition()
  const choose = () =>
    startTransition(async () => {
      const result = await chooseSolutionAction(discussionId, replyId)
      if (result.ok) showEffects(result.effects)
      router.refresh()
    })
  return (
    <Button
      variant="ghost"
      disabled={isPending}
      onClick={choose}
      className={cn(ACTION, chosen && "bg-ok-soft text-ok hover:bg-ok-soft hover:text-ok")}
    >
      <Check />
      {chosen ? "Meilleure réponse" : "Choisir comme meilleure réponse"}
    </Button>
  )
}

export function VerifyButton({ discussionId, replyId, verified }: { discussionId: string; replyId: string; verified: boolean }) {
  const router = useRouter()
  const { showEffects } = useEffects()
  const [isPending, startTransition] = useTransition()
  const verify = () =>
    startTransition(async () => {
      const result = await verifyReplyAction(discussionId, replyId)
      if (result.ok) showEffects(result.effects)
      router.refresh()
    })
  return (
    <Button
      variant="ghost"
      disabled={isPending}
      onClick={verify}
      className={cn(ACTION, verified && "bg-ok-soft text-ok hover:bg-ok-soft hover:text-ok")}
    >
      <BadgeCheck />
      {verified ? "Vérifiée par la rédaction" : "Valider cette réponse"}
    </Button>
  )
}

export function JumpButton({ targetId, label, className }: { targetId: string; label: string; className?: string }) {
  const jump = () => {
    const target = document.getElementById(targetId)
    if (!target) return
    target.scrollIntoView({ behavior: "smooth", block: "center" })
    target.classList.remove("animate-flash")
    void target.offsetWidth
    target.classList.add("animate-flash")
  }
  return (
    <Button variant="ghost" aria-label={label} onClick={jump} className={className} />
  )
}
