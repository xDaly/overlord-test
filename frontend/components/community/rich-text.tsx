import { Fragment, type ReactNode } from "react"

import { splitLinks } from "@/modules/moderation/domain/links"
import type { User } from "@/modules/users/domain/user"
import { UserLink } from "./user-link"

const BOLD = /\*\*(.+?)\*\*/g
const MENTION = /(^|[\s(])@([A-Za-z0-9_-]+(?:\.[A-Za-z0-9_-]+)*)/g
const MAX_LINK_LABEL = 48

type Users = Record<string, User>

function renderLinks(text: string, keyPrefix: string): ReactNode[] {
  return splitLinks(text).map((part, index) => {
    const key = `${keyPrefix}-l${index}`
    if (part.kind === "text") return <Fragment key={key}>{part.value}</Fragment>
    if (!part.trusted)
      return (
        <span key={key} className="[overflow-wrap:anywhere] text-ink-3" title="Lien en attente de validation par la modération">
          {part.raw}
          <small className="text-xs"> · lien en attente de validation</small>
        </span>
      )
    const shown = part.raw.replace(/^https?:\/\//i, "").replace(/^www\./i, "")
    return (
      <a
        key={key}
        className="text-brand-text underline underline-offset-2 [overflow-wrap:anywhere]"
        href={/^https?:/i.test(part.raw) ? part.raw : `https://${part.raw}`}
        target="_blank"
        rel="ugc nofollow noopener"
      >
        {shown.length > MAX_LINK_LABEL ? `${shown.slice(0, MAX_LINK_LABEL - 2)}…` : shown}
      </a>
    )
  })
}

function renderMentions(text: string, users: Users, keyPrefix: string): ReactNode[] {
  const nodes: ReactNode[] = []
  let cursor = 0
  for (const match of text.matchAll(MENTION)) {
    const user = users[match[2]]
    if (!user) continue
    const index = match.index ?? 0
    nodes.push(...renderLinks(text.slice(cursor, index) + match[1], `${keyPrefix}-${index}`))
    nodes.push(
      <UserLink key={`${keyPrefix}-m${index}`} user={user} className="bg-brand-soft px-1 font-semibold text-brand-text">
        @{user.username}
      </UserLink>
    )
    cursor = index + match[0].length
  }
  nodes.push(...renderLinks(text.slice(cursor), `${keyPrefix}-end`))
  return nodes
}

function renderInline(text: string, users: Users): ReactNode[] {
  const nodes: ReactNode[] = []
  let cursor = 0
  for (const match of text.matchAll(BOLD)) {
    const index = match.index ?? 0
    nodes.push(...renderMentions(text.slice(cursor, index), users, `t${index}`))
    nodes.push(
      <strong key={`b${index}`} className="font-semibold">
        {match[1]}
      </strong>
    )
    cursor = index + match[0].length
  }
  nodes.push(...renderMentions(text.slice(cursor), users, "tail"))
  return nodes
}

function renderLines(lines: string[], users: Users): ReactNode[] {
  return lines.flatMap((line, index) =>
    index === 0 ? renderInline(line, users) : [<br key={`br-${index}`} />, ...renderInline(line, users)]
  )
}

export function RichText({ text, users = {} }: { text: string; users?: Users }) {
  const blocks = text.split(/\n{2,}/).map((block) => block.split("\n"))
  return (
    <>
      {blocks.map((lines, blockIndex) => {
        const items = lines.filter((line) => line.startsWith("- "))
        const head = lines.filter((line) => !line.startsWith("- "))
        return (
          <Fragment key={blockIndex}>
            {head.length ? <p className="[&+p]:mt-[.8em]">{renderLines(head, users)}</p> : null}
            {items.length ? (
              <ul className="my-2 list-disc pl-[1.2em]">
                {items.map((item, itemIndex) => (
                  <li key={itemIndex}>{renderInline(item.slice(2), users)}</li>
                ))}
              </ul>
            ) : null}
          </Fragment>
        )
      })}
    </>
  )
}
