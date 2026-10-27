import type { User } from "../domain/user"

export interface UserRepository {
  list(): Promise<User[]>
  findByUsername(username: string): Promise<User | null>
}
