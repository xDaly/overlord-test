import { describe, expect, it } from "vitest";

import { CONTENT_MAX, castVote, parseNewDiscussion, parseReplyContent, slugify, toggleId, uniqueSlug } from "./discussion-rules";
import { scrubAuthors } from "./auth-rules";

const nameOf = (action: () => unknown) => {
  try {
    action();
  } catch (error) {
    return (error as Error).name;
  }
  return undefined;
};

describe("slugify", () => {
  it("builds a clean URL fragment from a French title", () => {
    expect(slugify("Ouvrir un PEA avec 5 000 € : par où commencer ?")).toBe("ouvrir-un-pea-avec-5-000-par-ou-commencer");
  });

  it("strips accents, quotes and repeated separators", () => {
    expect(slugify("  L'assurance-vie   et l'héritage !! ")).toBe("l-assurance-vie-et-l-heritage");
  });

  it("limits the length without leaving a trailing dash", () => {
    const slug = slugify("mot ".repeat(60));
    expect(slug.length).toBeLessThanOrEqual(80);
    expect(slug.endsWith("-")).toBe(false);
  });

  it("falls back to a default when nothing usable remains", () => {
    expect(slugify("???")).toBe("discussion");
  });
});

describe("uniqueSlug", () => {
  it("keeps the base slug when it is free", async () => {
    expect(await uniqueSlug("pea", async () => false)).toBe("pea");
  });

  it("adds a numeric suffix until the slug is free", async () => {
    const taken = new Set(["pea", "pea-2"]);
    expect(await uniqueSlug("pea", async (slug) => taken.has(slug))).toBe("pea-3");
  });
});

describe("parseNewDiscussion", () => {
  const valid = { title: "Comment placer 10 000 euros ?", content: "Bonjour", type: "question", category: "abc123" };

  it("keeps only the fields a member may set", () => {
    const parsed = parseNewDiscussion({
      ...valid,
      slug: "forcé",
      author: 9,
      pinned: true,
      featured: "poll",
      views: 5000,
      usefulBy: [1],
      followedBy: [1],
    });
    expect(parsed).toEqual({ title: "Comment placer 10 000 euros ?", content: "Bonjour", type: "question", category: "abc123" });
  });

  it("normalises the title spacing", () => {
    expect(parseNewDiscussion({ ...valid, title: "  Un   titre  assez long " }).title).toBe("Un titre assez long");
  });

  it("refuses a title under 10 characters", () => {
    expect(nameOf(() => parseNewDiscussion({ ...valid, title: "court" }))).toBe("ValidationError");
  });

  it("requires content unless the discussion is a poll", () => {
    expect(nameOf(() => parseNewDiscussion({ ...valid, content: "  " }))).toBe("ValidationError");
    expect(
      parseNewDiscussion({ ...valid, type: "poll", content: "", pollOptions: ["Oui", "Non"] })
    ).toMatchObject({ type: "poll", content: "" });
  });

  it("refuses an unknown type", () => {
    expect(nameOf(() => parseNewDiscussion({ ...valid, type: "annonce" }))).toBe("ValidationError");
  });

  it("requires a category", () => {
    expect(nameOf(() => parseNewDiscussion({ ...valid, category: undefined }))).toBe("ValidationError");
  });

  it("builds poll options and empty vote counts", () => {
    const parsed = parseNewDiscussion({ ...valid, type: "poll", pollOptions: [" Oui ", "Non", "", "Peut-être"] });
    expect(parsed.pollOptions).toEqual(["Oui", "Non", "Peut-être"]);
    expect(parsed.pollVotes).toEqual({ counts: [0, 0, 0], voters: {} });
  });

  it("refuses a poll with fewer than 2 options or more than 6", () => {
    expect(nameOf(() => parseNewDiscussion({ ...valid, type: "poll", pollOptions: ["Oui"] }))).toBe("ValidationError");
    expect(
      nameOf(() => parseNewDiscussion({ ...valid, type: "poll", pollOptions: ["1", "2", "3", "4", "5", "6", "7"] }))
    ).toBe("ValidationError");
  });

  it("ignores poll options on a regular discussion", () => {
    expect(parseNewDiscussion({ ...valid, pollOptions: ["a", "b"] })).not.toHaveProperty("pollOptions");
  });

  it("keeps an optional article title", () => {
    expect(parseNewDiscussion({ ...valid, article: " Les ETF en 2026 " }).article).toBe("Les ETF en 2026");
  });

  it("refuses a body without data", () => {
    expect(nameOf(() => parseNewDiscussion(undefined))).toBe("ValidationError");
  });
});

describe("parseReplyContent", () => {
  it("returns the trimmed text", () => {
    expect(parseReplyContent("  Comparez les frais.  ")).toBe("Comparez les frais.");
  });

  it.each([["empty", ""], ["blank", "   \n "], ["missing", undefined], ["not a string", 42]])("rejects %s content", (_label, value) => {
    expect(() => parseReplyContent(value)).toThrow(/content is required/);
  });

  it("rejects a text over the limit and accepts one at the limit", () => {
    expect(parseReplyContent("a".repeat(CONTENT_MAX))).toHaveLength(CONTENT_MAX);
    expect(() => parseReplyContent("a".repeat(CONTENT_MAX + 1))).toThrow(/at most/);
  });
});

describe("toggleId", () => {
  it("adds a member who was not in the list", () => {
    expect(toggleId([1, 2], 3)).toEqual({ ids: [1, 2, 3], active: true });
  });

  it("removes a member who was in the list", () => {
    expect(toggleId([1, 2, 3], 2)).toEqual({ ids: [1, 3], active: false });
  });
});

describe("castVote", () => {
  const empty = { counts: [0, 0, 0], voters: {} };

  it("counts a first vote", () => {
    expect(castVote(empty, 7, 1, 3)).toEqual({ votes: { counts: [0, 1, 0], voters: { "7": 1 } }, first: true });
  });

  it("moves a vote instead of adding a second one", () => {
    const { votes } = castVote(empty, 7, 1, 3);
    expect(castVote(votes, 7, 2, 3)).toEqual({ votes: { counts: [0, 0, 1], voters: { "7": 2 } }, first: false });
  });

  it("keeps the vote when the same option is chosen again", () => {
    const { votes } = castVote(empty, 7, 1, 3);
    expect(castVote(votes, 7, 1, 3).votes).toEqual(votes);
  });

  it("starts from seeded totals", () => {
    expect(castVote({ counts: [214, 268], voters: {} }, 1, 0, 2).votes.counts).toEqual([215, 268]);
  });

  it.each([-1, 3, 1.5, "1", undefined])("refuses the option %j", (option) => {
    expect(nameOf(() => castVote(empty, 7, option as number, 3))).toBe("ValidationError");
  });

  it("refuses a vote on a discussion without options", () => {
    expect(nameOf(() => castVote(null, 7, 0, 0))).toBe("ValidationError");
  });
});

describe("scrubAuthors with likes and follows", () => {
  it("also cleans the member lists and the discussion of a reply", () => {
    const leaky = { id: 1, username: "a", email: "a@b.fr" };
    const result = scrubAuthors({
      data: { id: 1, usefulBy: [leaky], followedBy: [leaky], discussion: { id: 2, author: leaky } },
      meta: {},
    });
    expect(result.data.usefulBy).toEqual([{ id: 1, username: "a" }]);
    expect(result.data.followedBy).toEqual([{ id: 1, username: "a" }]);
    expect(result.data.discussion.author).toEqual({ id: 1, username: "a" });
  });
});
