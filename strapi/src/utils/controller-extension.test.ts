import { describe, expect, it, vi } from "vitest";

import { afterAction } from "./controller-extension";

type Ctx = { body: { user?: { id: number } } & Record<string, unknown> };

/** Une fabrique comme celle de Users & Permissions : elle reçoit `{ strapi }` et renvoie les actions. */
const factory = () => ({
  async register(ctx: Ctx) {
    ctx.body = { jwt: "token", user: { id: 7 } };
  },
  async callback() {
    return "intact";
  },
});

describe("afterAction", () => {
  it("laisse l'action se dérouler, puis complète sa réponse", async () => {
    const wrapped = afterAction<{ strapi: string }, Ctx>(factory, "register", async (_deps, ctx) => {
      ctx.body = { ...ctx.body, effects: ["bienvenue"] };
    })({ strapi: "app" });
    const ctx: Ctx = { body: {} };
    await (wrapped.register as unknown as (ctx: Ctx) => Promise<void>)(ctx);
    expect(ctx.body).toEqual({ jwt: "token", user: { id: 7 }, effects: ["bienvenue"] });
  });

  it("donne à l'extension les dépendances de la fabrique et la requête", async () => {
    const extend = vi.fn(async () => {});
    const wrapped = afterAction<{ strapi: string }, Ctx>(factory, "register", extend)({ strapi: "app" });
    const ctx: Ctx = { body: {} };
    await (wrapped.register as unknown as (ctx: Ctx) => Promise<void>)(ctx);
    expect(extend).toHaveBeenCalledWith({ strapi: "app" }, ctx);
  });

  it("ne touche pas aux autres actions", async () => {
    const wrapped = afterAction<{ strapi: string }, Ctx>(factory, "register", async () => {})({ strapi: "app" });
    await expect((wrapped.callback as unknown as () => Promise<string>)()).resolves.toBe("intact");
  });

  it("échoue clairement si l'action n'existe pas (au lieu de ne rien faire en silence)", () => {
    expect(() => afterAction(factory, "inconnue", async () => {})({})).toThrow(/inconnue/);
  });
});
