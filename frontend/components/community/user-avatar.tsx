import { Check } from "lucide-react"

import { Avatar, AvatarBadge, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { cn } from "@/lib/utils"
import { initialsOf, type User } from "@/modules/users/domain/user"
import { UserLink } from "./user-link"

const SIZES = {
  xs: "size-[22px] text-[9.5px]",
  sm: "size-[30px] text-[11.5px]",
  md: "size-10 text-sm",
  lg: "size-14 text-[20px]",
  xl: "size-[84px] text-[28px]",
} as const

export type AvatarSize = keyof typeof SIZES

export function UserAvatar({
  user,
  size = "sm",
  link = false,
  className,
}: {
  user: User
  size?: AvatarSize
  link?: boolean
  className?: string
}) {
  const redaction = user.role === "redaction"
  const avatar = (
    <Avatar
      title={user.name}
      className={cn(SIZES[size], "overflow-visible after:hidden", redaction && "rounded-[28%]", className)}
    >
      {user.photo ? <AvatarImage src={user.photo} alt="" className={redaction ? "rounded-[28%]" : undefined} /> : null}
      <AvatarFallback
        className={cn(
          "font-semibold tracking-[.02em] text-white",
          redaction ? "rounded-[28%] font-display font-black tracking-[-.01em]" : "rounded-full"
        )}
        style={{
          background: `linear-gradient(180deg, color-mix(in srgb, ${user.color} 70%, #fff), ${user.color})`,
        }}
      >
        {size === "xs" ? initialsOf(user)[0] : initialsOf(user)}
      </AvatarFallback>
      {user.expertTitle && size !== "xs" && size !== "sm" ? (
        <AvatarBadge className="size-[38%] max-h-[22px] max-w-[22px] bg-pro ring-2 ring-card">
          <Check className="size-[62%] stroke-[3.5] text-white" />
        </AvatarBadge>
      ) : null}
    </Avatar>
  )
  return link ? (
    <UserLink user={user} className="relative z-10 inline-flex rounded-full">
      {avatar}
    </UserLink>
  ) : (
    avatar
  )
}

export function AvatarStack({ users }: { users: User[] }) {
  return (
    <span className="inline-flex">
      {users.map((user) => (
        <UserAvatar key={user.username} user={user} size="xs" className="-ml-[7px] ring-2 ring-card first:ml-0" />
      ))}
    </span>
  )
}
