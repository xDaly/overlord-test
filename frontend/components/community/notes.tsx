"use client"

import { ChevronLeft, ChevronRight, X } from "lucide-react"
import { createContext, useCallback, useContext, useMemo, useState, type ReactNode } from "react"

import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"
import { DESIGN_NOTES, NOTE_KEYS, type NoteKey } from "@/modules/community/presentation/design-notes"

type NotesContext = {
  enabled: boolean
  current: NoteKey | null
  toggle: (firstNote: NoteKey) => void
  open: (key: NoteKey) => void
  close: () => void
  step: (direction: 1 | -1) => void
}

const Context = createContext<NotesContext | null>(null)

export function NotesProvider({ children }: { children: ReactNode }) {
  const [enabled, setEnabled] = useState(false)
  const [current, setCurrent] = useState<NoteKey | null>(null)

  const toggle = useCallback((firstNote: NoteKey) => {
    setEnabled((previous) => !previous)
    setCurrent((previous) => (previous === null ? firstNote : null))
  }, [])
  const open = useCallback((key: NoteKey) => setCurrent(key), [])
  const close = useCallback(() => setCurrent(null), [])
  const step = useCallback(
    (direction: 1 | -1) =>
      setCurrent((previous) => {
        const index = NOTE_KEYS.indexOf(previous ?? NOTE_KEYS[0])
        return NOTE_KEYS[(index + direction + NOTE_KEYS.length) % NOTE_KEYS.length]
      }),
    []
  )

  const value = useMemo(() => ({ enabled, current, toggle, open, close, step }), [enabled, current, toggle, open, close, step])
  return (
    <Context.Provider value={value}>
      {children}
      <NotePanel />
    </Context.Provider>
  )
}

export function useNotes(): NotesContext {
  const context = useContext(Context)
  if (!context) throw new Error("useNotes doit être utilisé dans NotesProvider")
  return context
}

const PIN =
  "inline-grid size-[22px] shrink-0 place-items-center rounded-full bg-note p-0 align-middle text-[11.5px] font-bold tracking-normal text-note-ink normal-case tabular-nums shadow-[0_0_0_3px_color-mix(in_srgb,var(--note)_30%,transparent)]"

export function NotePin({ k, className }: { k: NoteKey; className?: string }) {
  const { enabled, open } = useNotes()
  if (!enabled) return null
  const index = NOTE_KEYS.indexOf(k) + 1
  return (
    <Button
      variant="ghost"
      aria-label={`Note de conception ${index}`}
      onClick={(event) => {
        event.preventDefault()
        event.stopPropagation()
        open(k)
      }}
      className={cn(PIN, "h-[22px] min-w-0 animate-note-pulse font-sans hover:scale-110 hover:bg-note hover:text-note-ink", className)}
    >
      {index}
    </Button>
  )
}

function NotePanel() {
  const { current, close, step } = useNotes()
  if (!current) return null
  const note = DESIGN_NOTES[current]
  const index = NOTE_KEYS.indexOf(current)
  return (
    <aside
      role="dialog"
      aria-label="Note de conception"
      className="fixed bottom-4 left-4 z-[85] w-[min(400px,calc(100vw-32px))] rounded-lg border border-hairline bg-card px-[18px] py-4 shadow-[inset_0_3px_0_var(--note),var(--shadow-lg)] animate-in fade-in-0 slide-in-from-bottom-3 duration-200 max-[760px]:bottom-[76px]"
    >
      <div className="mb-2 flex items-center gap-2.5">
        <span className={PIN}>{index + 1}</span>
        <h3 className="flex-1 font-display text-base font-bold tracking-[-.01em]">{note.title}</h3>
        <Button variant="ghost" size="icon" aria-label="Fermer" onClick={close}>
          <X />
        </Button>
      </div>
      <p className="text-sm leading-[1.55] text-ink-2">{note.text}</p>
      <p className="mt-2.5 text-[12.5px] text-ink-3">
        Référence : <b className="font-semibold text-note">{note.reference}</b>
      </p>
      <div className="mt-3 flex items-center gap-2">
        <Button variant="ghost" size="sm" onClick={() => step(-1)}>
          <ChevronLeft />
          Précédente
        </Button>
        <Button variant="ghost" size="sm" onClick={() => step(1)}>
          Suivante
          <ChevronRight />
        </Button>
        <span className="ml-auto text-[12.5px] text-ink-3">
          {index + 1} / {NOTE_KEYS.length}
        </span>
      </div>
    </aside>
  )
}
