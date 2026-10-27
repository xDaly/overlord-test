import { AppError, type AppErrorCode, type FieldErrors } from "@/lib/errors"
import type { Effect } from "@/modules/users/domain/gamification"
import type { MessageEffect } from "../application/deps"

export type UiEffect = Effect | MessageEffect

export type ActionResult<T = undefined> =
  | { ok: true; data: T; effects: UiEffect[] }
  | { ok: false; error: AppErrorCode | "unknown"; fields: FieldErrors }

export async function run<T>(
  action: () => Promise<{ data: T; effects?: UiEffect[] }>
): Promise<ActionResult<T>> {
  try {
    const { data, effects = [] } = await action()
    return { ok: true, data, effects }
  } catch (error) {
    if (error instanceof AppError) return { ok: false, error: error.code, fields: error.fields }
    console.error(error)
    return { ok: false, error: "unknown", fields: {} }
  }
}
