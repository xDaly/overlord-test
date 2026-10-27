export function readDraft<T>(key: string): T | null {
  try {
    const raw = localStorage.getItem(`lr-draft:${key}`)
    return raw ? (JSON.parse(raw) as T) : null
  } catch {
    return null
  }
}

export function writeDraft(key: string, value: unknown): void {
  try {
    localStorage.setItem(`lr-draft:${key}`, JSON.stringify(value))
  } catch {
  }
}

export function clearDraft(key: string): void {
  try {
    localStorage.removeItem(`lr-draft:${key}`)
  } catch {
  }
}
