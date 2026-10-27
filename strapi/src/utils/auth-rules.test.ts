import { describe, expect, it } from "vitest";

import {
  authorizeReplyUpdate,
  diffPermissions,
  forceAuthor,
  forceReplyAuthor,
  pickEditable,
  requireUser,
  scrubAuthors,
  toPublicAuthor,
} from "./auth-rules";

const alice = { id: 1 };
const bob = { id: 2 };

describe("requireUser", () => {
  it("refuses an unauthenticated request with a 401 error", () => {
    expect(() => requireUser(undefined)).toThrow(expect.objectContaining({ name: "UnauthorizedError" }));
    expect(() => requireUser(null)).toThrow(expect.objectContaining({ name: "UnauthorizedError" }));
  });

  it("returns the signed-in user", () => {
    expect(requireUser(alice)).toBe(alice);
  });
});

describe("forceAuthor", () => {
  it("sets the author to the signed-in user", () => {
    expect(forceAuthor({ title: "Un titre assez long" }, alice)).toEqual({ title: "Un titre assez long", author: 1 });
  });

  it("overwrites an author supplied by the client, so nobody can post as someone else", () => {
    expect(forceAuthor({ title: "Un titre assez long", author: 2 }, alice).author).toBe(1);
    expect(forceAuthor({ author: { connect: [{ id: 2 }] } }, alice).author).toBe(1);
  });

  it("rejects a body without a data object", () => {
    expect(() => forceAuthor(undefined, alice)).toThrow(expect.objectContaining({ name: "ValidationError" }));
    expect(() => forceAuthor("x", alice)).toThrow(expect.objectContaining({ name: "ValidationError" }));
  });
});

describe("forceReplyAuthor", () => {
  it("never lets a new reply claim to be the best answer", () => {
    expect(forceReplyAuthor({ content: "Oui", isBestAnswer: true }, alice)).toEqual({
      content: "Oui",
      isBestAnswer: false,
      author: 1,
    });
  });
});

describe("pickEditable", () => {
  it("keeps only the allowed fields", () => {
    expect(pickEditable({ title: "t", author: 2, slug: "x", replies: [] }, ["title", "content"])).toEqual({ title: "t" });
  });
});

describe("authorizeReplyUpdate", () => {
  const reply = { authorId: 1, discussionAuthorId: 2 };

  it("lets the reply author edit the content only", () => {
    expect(authorizeReplyUpdate({ ...reply, user: alice, data: { content: "Corrigé", isBestAnswer: true, author: 9 } })).toEqual({
      content: "Corrigé",
    });
  });

  it("lets the discussion author choose the best answer only", () => {
    expect(authorizeReplyUpdate({ ...reply, user: bob, data: { isBestAnswer: true, content: "Détourné" } })).toEqual({
      isBestAnswer: true,
    });
  });

  it("refuses a third user", () => {
    expect(() => authorizeReplyUpdate({ ...reply, user: { id: 3 }, data: { content: "x" } })).toThrow(
      expect.objectContaining({ name: "ForbiddenError" })
    );
  });

  it("refuses an update that changes nothing the user may change", () => {
    expect(() => authorizeReplyUpdate({ ...reply, user: alice, data: { isBestAnswer: true } })).toThrow(
      expect.objectContaining({ name: "ForbiddenError" })
    );
  });

  it("lets one user who wrote the reply and the discussion do both", () => {
    expect(
      authorizeReplyUpdate({ authorId: 1, discussionAuthorId: 1, user: alice, data: { content: "ok", isBestAnswer: true } })
    ).toEqual({ content: "ok", isBestAnswer: true });
  });
});

describe("toPublicAuthor", () => {
  it("drops private fields such as the e-mail address", () => {
    const author = { id: 1, documentId: "d", username: "alice", displayName: "Alice", bio: "b", email: "a@b.fr", provider: "local", blocked: false };
    expect(toPublicAuthor(author)).toEqual({ id: 1, documentId: "d", username: "alice", displayName: "Alice", bio: "b" });
  });

  it("keeps the public community profile (role, points, badges)", () => {
    const author = { username: "alice", communityRole: "redaction", points: 12, badges: ["bienvenue"], resetPasswordToken: "x" };
    expect(toPublicAuthor(author)).toEqual({ username: "alice", communityRole: "redaction", points: 12, badges: ["bienvenue"] });
  });

  it("leaves a missing author untouched", () => {
    expect(toPublicAuthor(null)).toBeNull();
    expect(toPublicAuthor(undefined)).toBeUndefined();
  });
});

describe("scrubAuthors", () => {
  it("cleans the authors of a list of discussions and of their replies", () => {
    const leaky = { id: 1, username: "a", email: "a@b.fr" };
    const result = scrubAuthors({
      data: [{ id: 1, author: leaky, replies: [{ id: 2, author: leaky }] }],
      meta: { pagination: { page: 1 } },
    });
    expect(result.data[0].author).toEqual({ id: 1, username: "a" });
    expect(result.data[0].replies[0].author).toEqual({ id: 1, username: "a" });
    expect(result.meta).toEqual({ pagination: { page: 1 } });
  });

  it("cleans a single entry", () => {
    const result = scrubAuthors({ data: { id: 1, author: { id: 1, email: "a@b.fr" } }, meta: {} });
    expect(result.data.author).toEqual({ id: 1 });
  });

  it("tolerates a null payload", () => {
    expect(scrubAuthors({ data: null, meta: {} })).toEqual({ data: null, meta: {} });
  });
});

describe("diffPermissions", () => {
  it("lists what to create and what to delete", () => {
    expect(diffPermissions(["a", "b"], ["b", "c"])).toEqual({ toCreate: ["c"], toDelete: ["a"] });
  });

  it("does nothing when both sides match", () => {
    expect(diffPermissions(["a"], ["a"])).toEqual({ toCreate: [], toDelete: [] });
  });
});
