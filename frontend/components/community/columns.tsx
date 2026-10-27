import { community } from "@/modules/community/community.container"
import type { User } from "@/modules/users/domain/user"
import { JoinCard } from "./join-card"
import { SiteNewsCard } from "./site-news-card"
import { BlogWidget, EventsWidget, PollWidget, ProgressCard, QuestionWidget, TopWidget } from "./widgets"

const TOP_COUNT = 5
const BLOG_COUNT = 3

async function topMembers(): Promise<User[]> {
  return (await community().users.list())
    .filter((member) => member.role === "member")
    .sort((a, b) => b.month - a.month)
    .slice(0, TOP_COUNT)
}

const memberOrJoin = (user: User | null) => (user ? <ProgressCard user={user} /> : <JoinCard />)

export async function HomeRight({ user }: { user: User | null }) {
  const deps = community()
  const viewer = user?.username
  const [question, poll, posts, events, top] = await Promise.all([
    deps.discussions.featured("question", viewer),
    deps.discussions.featured("poll", viewer),
    deps.blogs.list(),
    deps.events.list(),
    topMembers(),
  ])
  return (
    <>
      {memberOrJoin(user)}
      {question ? <QuestionWidget discussion={question} /> : null}
      {poll ? <PollWidget discussion={poll} className="max-[760px]:hidden" /> : null}
      <BlogWidget posts={posts.slice(0, BLOG_COUNT)} canWrite={Boolean(user)} />
      <SiteNewsCard />
      <EventsWidget events={events} />
      <TopWidget members={top} />
    </>
  )
}

export async function CategoryRight({ user, slug }: { user: User | null; slug: string }) {
  const deps = community()
  const [events, top] = await Promise.all([deps.events.list({ categorySlug: slug }), topMembers()])
  return (
    <>
      {memberOrJoin(user)}
      <EventsWidget events={events} />
      <TopWidget members={top} />
    </>
  )
}
