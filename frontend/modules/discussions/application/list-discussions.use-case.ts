import type { CommunityDeps } from "@/modules/community/application/deps"
import type { Discussion, ListDiscussionsQuery, Page } from "../domain/discussion"

export function listDiscussions(
  deps: Pick<CommunityDeps, "discussions">,
  query: ListDiscussionsQuery
): Promise<Page<Discussion>> {
  return deps.discussions.list(query)
}
