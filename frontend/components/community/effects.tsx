"use client"

import {
  AtSign,
  BadgeCheck,
  Bell,
  Calendar,
  Camera,
  Check,
  Eye,
  Globe,
  Link2,
  Shield,
  ThumbsUp,
  Trophy,
  User as UserIcon,
  type LucideIcon,
} from "lucide-react"
import { useCallback, type ReactNode } from "react"
import { toast } from "sonner"

import { cn } from "@/lib/utils"
import type { MessageEffect } from "@/modules/community/application/deps"
import type { UiEffect } from "@/modules/community/presentation/action-result"
import { BADGES } from "@/modules/users/domain/badges"
import { BadgeIcon } from "./badge-icon"
import { NotePin } from "./notes"

const ICONS: Record<MessageEffect["icon"], LucideIcon> = {
  thumb: ThumbsUp,
  bell: Bell,
  check: Check,
  verified: BadgeCheck,
  calendar: Calendar,
  link: Link2,
  shield: Shield,
  camera: Camera,
  at: AtSign,
  eye: Eye,
  user: UserIcon,
  globe: Globe,
}

const DEFAULT_DURATION = 4200
const LONG_DURATION = 5200

function ToastCard({ children, className }: { children: ReactNode; className?: string }) {
  return (
    <div
      role="status"
      className={cn(
        "pointer-events-auto flex w-[min(380px,calc(100vw-32px))] items-center gap-3 rounded-2xl border border-hairline bg-glass-strong px-4 py-3 text-sm text-foreground shadow-pop backdrop-blur-[30px] backdrop-saturate-[180%]",
        className
      )}
    >
      {children}
    </div>
  )
}

const Small = ({ children }: { children: ReactNode }) => (
  <small className="block text-[12.5px] opacity-75">{children}</small>
)

function show(effect: UiEffect) {
  switch (effect.kind) {
    case "points":
      return toast.custom(
        () => (
          <ToastCard>
            <span className="text-base font-bold text-brand-text tabular-nums">+{effect.points}</span>
            <div>
              {effect.reason}
              <Small>{effect.total} points au total</Small>
            </div>
          </ToastCard>
        ),
        { duration: DEFAULT_DURATION }
      )
    case "level":
      return toast.custom(
        () => (
          <ToastCard className="border-transparent bg-brand text-white">
            <Trophy className="size-[18px]" />
            <div>
              <b>Niveau supérieur !</b>
              <Small>Vous êtes maintenant « {effect.name} »</Small>
            </div>
          </ToastCard>
        ),
        { duration: LONG_DURATION }
      )
    case "badge":
      return toast.custom(
        () => (
          <ToastCard>
            <BadgeIcon code={effect.code} className="size-9 bg-brand text-white" />
            <div>
              <b>Nouveau badge : {BADGES[effect.code].name}</b>
              <Small>{BADGES[effect.code].description}</Small>
            </div>
            <NotePin k="rewards" />
          </ToastCard>
        ),
        { duration: LONG_DURATION }
      )
    case "message": {
      const Icon = ICONS[effect.icon]
      return toast.custom(
        () => (
          <ToastCard>
            <Icon className="size-[18px] shrink-0" />
            <div>
              {effect.title ? <b>{effect.title}</b> : effect.text}
              {effect.title ? <Small>{effect.text}</Small> : null}
            </div>
          </ToastCard>
        ),
        { duration: LONG_DURATION }
      )
    }
  }
}

const STAGGER: Record<UiEffect["kind"], number> = { points: 0, level: 700, badge: 900, message: 0 }

export function useEffects() {
  const showEffects = useCallback((effects: UiEffect[]) => {
    for (const effect of effects) {
      const delay = effect.kind === "message" ? (effect.delayMs ?? 0) : STAGGER[effect.kind]
      if (delay) setTimeout(() => show(effect), delay)
      else show(effect)
    }
  }, [])

  const showMessage = useCallback(
    (icon: MessageEffect["icon"], text: string, title?: string) => show({ kind: "message", icon, text, title }),
    []
  )

  return { showEffects, showMessage }
}
