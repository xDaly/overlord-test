"use server"

import { revalidatePath } from "next/cache"

import { community } from "@/modules/community/community.container"
import { run, type ActionResult } from "@/modules/community/presentation/action-result"
import { getSessionUser } from "@/modules/community/presentation/session"
import { toggleRsvp } from "../application/toggle-rsvp.use-case"

export async function toggleRsvpAction(eventId: string): Promise<ActionResult<{ joined: boolean }>> {
  const result = await run(async () => {
    const { joined } = await toggleRsvp(community(), await getSessionUser(), eventId)
    return {
      data: { joined },
      effects: joined
        ? [
            {
              kind: "message",
              icon: "calendar",
              title: "C'est noté !",
              text: "Rappel la veille par notification et e-mail. Vous pouvez déjà poser vos questions.",
            } as const,
          ]
        : [],
    }
  })
  if (result.ok) revalidatePath("/", "layout")
  return result
}
