import type { Core } from "@strapi/strapi";
import { describe, expect, it, vi } from "vitest";

import isAuthenticated from "./is-authenticated";
import isNotOwner from "./is-not-owner";
import isOwner from "./is-owner";

const config = { uid: "api::discussion.discussion", ownerField: "author" };

/** Un Strapi minimal : `documents(uid).findOne` renvoie le document programmé, ou null. */
const strapiWith = (entry: Record<string, unknown> | null) => {
  const findOne = vi.fn(async () => entry);
  const strapi = { documents: vi.fn(() => ({ findOne })) } as unknown as Core.Strapi;
  return { strapi, findOne };
};

const context = (user: { id: number } | null, id: string | undefined = "doc1") => ({ state: { user }, params: { id } });

describe("is-authenticated", () => {
  it("laisse passer un membre connecté et refuse un visiteur", () => {
    expect(isAuthenticated(context({ id: 1 }))).toBe(true);
    expect(isAuthenticated(context(null))).toBe(false);
  });
});

describe("is-owner", () => {
  it("laisse le propriétaire modifier son contenu", async () => {
    const { strapi } = strapiWith({ author: { id: 7 } });
    expect(await isOwner(context({ id: 7 }), config, { strapi })).toBe(true);
  });

  it("refuse un autre membre", async () => {
    const { strapi } = strapiWith({ author: { id: 7 } });
    expect(await isOwner(context({ id: 8 }), config, { strapi })).toBe(false);
  });

  it("refuse un visiteur sans même interroger la base", async () => {
    const { strapi, findOne } = strapiWith({ author: { id: 7 } });
    expect(await isOwner(context(null), config, { strapi })).toBe(false);
    expect(findOne).not.toHaveBeenCalled();
  });

  it("refuse un contenu sans propriétaire connu", async () => {
    const { strapi } = strapiWith({ author: null });
    expect(await isOwner(context({ id: 7 }), config, { strapi })).toBe(false);
  });

  it("laisse passer un document introuvable : la route répond 404", async () => {
    const { strapi } = strapiWith(null);
    expect(await isOwner(context({ id: 7 }), config, { strapi })).toBe(true);
  });

  it("lit le propriétaire dans le champ configuré, par documentId", async () => {
    const { strapi, findOne } = strapiWith({ recipient: { id: 7 } });
    await isOwner(context({ id: 7 }, "abc"), { uid: "api::notification.notification", ownerField: "recipient" }, { strapi });
    expect(strapi.documents).toHaveBeenCalledWith("api::notification.notification");
    expect(findOne).toHaveBeenCalledWith({ documentId: "abc", fields: ["id"], populate: { recipient: { fields: ["id"] } } });
  });
});

describe("is-not-owner", () => {
  it("refuse l'auteur et laisse passer un autre membre", async () => {
    const { strapi } = strapiWith({ author: { id: 7 } });
    expect(await isNotOwner(context({ id: 7 }), config, { strapi })).toBe(false);
    expect(await isNotOwner(context({ id: 8 }), config, { strapi })).toBe(true);
  });

  it("refuse un visiteur et laisse passer un document introuvable", async () => {
    expect(await isNotOwner(context(null), config, { strapi: strapiWith(null).strapi })).toBe(false);
    expect(await isNotOwner(context({ id: 8 }), config, { strapi: strapiWith(null).strapi })).toBe(true);
  });
});
