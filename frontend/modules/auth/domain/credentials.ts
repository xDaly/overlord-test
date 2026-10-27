import { AppError, type FieldErrors } from "@/lib/errors"

export const USERNAME_PATTERN = /^[A-Za-z0-9_]{3,24}$/
export const MIN_PASSWORD_LENGTH = 8

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/

export type LoginInput = { identifier: string; password: string }
export type RegistrationInput = { username: string; email: string; password: string }

const text = (value: unknown) => (typeof value === "string" ? value : "")

function assertValid(fields: FieldErrors) {
  if (Object.keys(fields).length > 0) throw new AppError("validation", fields)
}

export function parseLogin(input: unknown): LoginInput {
  const raw = (input ?? {}) as Record<string, unknown>
  const identifier = text(raw.identifier).trim()
  const password = text(raw.password)
  const fields: FieldErrors = {}
  if (!identifier) fields.identifier = "identifier.required"
  if (!password) fields.password = "password.required"
  assertValid(fields)
  return { identifier, password }
}

export function parseRegistration(input: unknown): RegistrationInput {
  const raw = (input ?? {}) as Record<string, unknown>
  const username = text(raw.username).trim()
  const email = text(raw.email).trim().toLowerCase()
  const password = text(raw.password)
  const fields: FieldErrors = {}
  if (!USERNAME_PATTERN.test(username)) fields.username = "username.invalid"
  if (!EMAIL_PATTERN.test(email)) fields.email = "email.invalid"
  if (password.length < MIN_PASSWORD_LENGTH) fields.password = "password.tooShort"
  else if (!/\p{L}/u.test(password) || !/\d/.test(password)) fields.password = "password.weak"
  assertValid(fields)
  return { username, email, password }
}
