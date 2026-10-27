"use client"

import { AtSign } from "lucide-react"
import { useEffect, useRef, useState, type ReactNode } from "react"

import { Button } from "@/components/ui/button"
import { Popover, PopoverContent } from "@/components/ui/popover"
import { Textarea } from "@/components/ui/textarea"
import { caretRect, type CaretRect } from "@/lib/caret"
import { clearDraft, readDraft, writeDraft } from "@/lib/drafts"
import { cn } from "@/lib/utils"
import { mentionCandidates } from "@/modules/users/domain/gamification"
import type { User } from "@/modules/users/domain/user"
import { useCommunity } from "./community-context"
import { LinkNote } from "./link-note"
import { NotePin } from "./notes"
import { UserAvatar } from "./user-avatar"

const TRIGGER = /(^|[\s(])@([\p{L}\p{N}_.\-]{0,24})$/u

type Open = { start: number; query: string; items: User[]; index: number; rect: CaretRect }

export function MentionField({
  id,
  name,
  rows,
  placeholder,
  participants = [],
  draftKey,
  defaultValue = "",
  invalid,
  hint,
  className,
  onTextChange,
}: {
  id: string
  name: string
  rows?: number
  placeholder?: string
  participants?: string[]
  draftKey?: string
  defaultValue?: string
  invalid?: boolean
  hint: ReactNode
  className?: string
  onTextChange?: (value: string) => void
}) {
  const { user, users } = useCommunity()
  const ref = useRef<HTMLTextAreaElement>(null)
  const [text, setText] = useState(defaultValue)
  const [open, setOpen] = useState<Open | null>(null)

  useEffect(() => {
    if (!draftKey || defaultValue) return
    const saved = readDraft<string>(draftKey)
    if (saved && ref.current) {
      ref.current.value = saved
      setText(saved)
    }
  }, [draftKey, defaultValue])

  const check = () => {
    const field = ref.current
    if (!field || !user) return setOpen(null)
    const match = field.value.slice(0, field.selectionStart).match(TRIGGER)
    if (!match) return setOpen(null)
    const query = match[2]
    setOpen({
      start: field.selectionStart - query.length - 1,
      query,
      items: mentionCandidates(users, { query, me: user.username, participants }),
      index: 0,
      rect: caretRect(field),
    })
  }

  const handleInput = () => {
    const value = ref.current?.value ?? ""
    setText(value)
    onTextChange?.(value)
    if (draftKey && value) writeDraft(draftKey, value)
    else if (draftKey) clearDraft(draftKey)
    check()
  }

  const pick = (item: User) => {
    const field = ref.current
    if (!field || !open) return
    field.setRangeText(`@${item.username} `, open.start, field.selectionStart, "end")
    field.focus()
    setOpen(null)
    handleInput()
  }

  const startMention = () => {
    const field = ref.current
    if (!field) return
    field.focus()
    const position = field.selectionStart
    const before = field.value.slice(0, position)
    field.setRangeText(`${before && !/\s$/.test(before) ? " " : ""}@`, position, field.selectionEnd, "end")
    handleInput()
  }

  const handleKeyDown = (event: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (open) {
      if ((event.key === "ArrowDown" || event.key === "ArrowUp") && open.items.length) {
        event.preventDefault()
        const step = event.key === "ArrowDown" ? 1 : -1
        setOpen({ ...open, index: (open.index + step + open.items.length) % open.items.length })
        return
      }
      if (((event.key === "Enter" && !event.ctrlKey && !event.metaKey) || event.key === "Tab") && open.items.length) {
        event.preventDefault()
        pick(open.items[open.index])
        return
      }
      if (event.key === "Escape") {
        event.preventDefault()
        event.stopPropagation()
        setOpen(null)
        return
      }
    }
    if (event.key === "Enter" && (event.ctrlKey || event.metaKey)) ref.current?.form?.requestSubmit()
  }

  const anchor = open
    ? { getBoundingClientRect: () => new DOMRect(open.rect.x - 14, open.rect.top, 0, open.rect.bottom - open.rect.top) }
    : undefined

  return (
    <div className="flex flex-col gap-1.5">
      <Textarea
        ref={ref}
        id={id}
        name={name}
        rows={rows}
        placeholder={placeholder}
        defaultValue={defaultValue}
        aria-invalid={invalid}
        className={className}
        onInput={handleInput}
        onKeyDown={handleKeyDown}
        onKeyUp={(event) => {
          if (open && ["ArrowLeft", "ArrowRight", "Home", "End"].includes(event.key)) check()
        }}
        onBlur={() => setTimeout(() => document.activeElement !== ref.current && setOpen(null), 120)}
      />
      <div className="flex flex-wrap items-center gap-2">
        <Button variant="ghost" size="sm" className="h-8 gap-1.5 rounded-lg px-[11px] text-[13.5px] font-medium" onClick={startMention}>
          <AtSign />
          Mentionner
        </Button>
        <NotePin k="mention" />
        <span className="text-[12.5px] text-ink-3">{hint}</span>
      </div>
      <LinkNote text={text} />
      <Popover open={Boolean(open)} onOpenChange={(next) => !next && setOpen(null)}>
        <PopoverContent
          anchor={anchor}
          align="start"
          side="bottom"
          sideOffset={6}
          initialFocus={false}
          finalFocus={false}
          className="w-[280px] gap-0 rounded-xl border border-hairline p-1.5 shadow-pop ring-0"
          onMouseDown={(event) => event.preventDefault()}
          aria-label="Mentionner un membre"
        >
          <div className="px-2 pt-1 pb-1.5 text-[11.5px] font-semibold text-ink-3">
            {open?.query ? `Membres correspondant à « ${open.query} »` : "Mentionner un membre"}
          </div>
          {open?.items.length ? (
            open.items.map((item, index) => (
              <Button
                key={item.username}
                variant="ghost"
                role="option"
                aria-selected={index === open.index}
                onClick={() => pick(item)}
                className={cn(
                  "h-auto w-full justify-start gap-2.5 rounded-lg px-2 py-1.5 text-left font-normal",
                  index === open.index && "bg-brand text-white hover:bg-brand hover:text-white"
                )}
              >
                <UserAvatar user={item} size="sm" />
                <span>
                  <b className="block text-sm leading-tight font-semibold">{item.name}</b>
                  <small className={cn("block text-xs", index === open.index ? "text-white/80" : "text-ink-3")}>
                    @{item.username}
                    {item.role === "redaction" ? " · Rédaction" : participants.includes(item.username) ? " · dans cette page" : ""}
                  </small>
                </span>
              </Button>
            ))
          ) : (
            <div className="p-2 text-[13px] text-ink-3">Aucun membre ne correspond.</div>
          )}
        </PopoverContent>
      </Popover>
    </div>
  )
}
