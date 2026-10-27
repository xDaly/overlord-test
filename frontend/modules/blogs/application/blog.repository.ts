import type { Published, UsefulResult } from "@/modules/community/application/deps"
import type { BlogComment, BlogPost, BlogPostDetail, NewBlogInput } from "../domain/blog"

export interface BlogRepository {
  list(): Promise<BlogPost[]>
  findById(id: string): Promise<BlogPostDetail | null>
  listByAuthor(username: string): Promise<BlogPost[]>
  create(input: NewBlogInput): Promise<Published<BlogPostDetail>>
  addComment(blogId: string, content: string): Promise<Published<BlogComment> | null>
  toggleLike(blogId: string, commentId: string | null): Promise<UsefulResult | null>
}
