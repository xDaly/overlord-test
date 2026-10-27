import type { Category } from "@/modules/categories/domain/category"
import type { User } from "@/modules/users/domain/user"

export type BlogComment = {
  id: string
  content: string
  createdAt: string
  likes: number
  liked: boolean
  author: User
}

export type BlogPost = {
  id: string
  title: string
  content: string
  category: Category | null
  createdAt: string
  likes: number
  liked: boolean
  views: number
  author: User
  commentsCount: number
}

export type BlogPostDetail = BlogPost & { comments: BlogComment[] }

export const MIN_BLOG_TITLE_LENGTH = 10
export const MIN_BLOG_LENGTH = 60
export const MAX_BLOG_TITLE_LENGTH = 120

export type NewBlogInput = { title: string; content: string; categorySlug: string | null }
export type NewBlogErrors = Partial<Record<"title" | "content", string>>

export function validateNewBlog(input: NewBlogInput): NewBlogErrors {
  const errors: NewBlogErrors = {}
  if (input.title.trim().replace(/\s+/g, " ").length < MIN_BLOG_TITLE_LENGTH) errors.title = "title.tooShort"
  if (input.content.trim().length < MIN_BLOG_LENGTH) errors.content = "content.tooShort"
  return errors
}

export const readTime = (content: string) => Math.max(1, Math.round(content.split(/\s+/).length / 200))
