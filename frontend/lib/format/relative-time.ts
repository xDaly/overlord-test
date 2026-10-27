const MINUTE = 60_000

export function formatRelativeTime(iso: string, now: Date = new Date()): string {
  const minutes = (now.getTime() - new Date(iso).getTime()) / MINUTE
  if (minutes < 1) return "à l'instant"
  if (minutes < 60) return `il y a ${Math.round(minutes)} min`
  const hours = Math.round(minutes / 60)
  if (hours < 24) return `il y a ${hours} h`
  const days = Math.round(hours / 24)
  return days === 1 ? "hier" : `il y a ${days} j`
}

export function isWithin(iso: string, windowMs: number, now: Date = new Date()): boolean {
  return now.getTime() - new Date(iso).getTime() < windowMs
}
