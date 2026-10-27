export type AppErrorCode = "unauthenticated" | "validation" | "not-found" | "forbidden" | "unavailable"

export type FieldErrors = Record<string, string>

export class AppError extends Error {
  readonly code: AppErrorCode
  readonly fields: FieldErrors

  constructor(code: AppErrorCode, fields: FieldErrors = {}) {
    super(code)
    this.name = "AppError"
    this.code = code
    this.fields = fields
  }
}
