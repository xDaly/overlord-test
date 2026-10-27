const MIRRORED = [
  "boxSizing", "width", "paddingTop", "paddingRight", "paddingBottom", "paddingLeft",
  "borderTopWidth", "borderRightWidth", "borderBottomWidth", "borderLeftWidth",
  "fontFamily", "fontSize", "fontWeight", "lineHeight", "letterSpacing", "wordSpacing", "textIndent",
] as const

export type CaretRect = { x: number; top: number; bottom: number }

export function caretRect(textarea: HTMLTextAreaElement): CaretRect {
  const style = getComputedStyle(textarea)
  const mirror = document.createElement("div")
  for (const property of MIRRORED) mirror.style[property] = style[property]
  Object.assign(mirror.style, {
    position: "absolute",
    visibility: "hidden",
    whiteSpace: "pre-wrap",
    overflowWrap: "break-word",
    top: "0",
    left: "-9999px",
  })
  mirror.textContent = textarea.value.slice(0, textarea.selectionStart)
  const marker = document.createElement("span")
  marker.textContent = "​"
  mirror.appendChild(marker)
  document.body.appendChild(mirror)
  const box = textarea.getBoundingClientRect()
  const lineHeight = parseFloat(style.lineHeight) || parseFloat(style.fontSize) * 1.4
  const x = box.left + marker.offsetLeft - textarea.scrollLeft
  const top = box.top + marker.offsetTop - textarea.scrollTop
  mirror.remove()
  return { x, top, bottom: top + lineHeight }
}
