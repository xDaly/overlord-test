/**
 * Les controllers de Users & Permissions ne sont pas tous des objets. Dans Strapi v5, `auth` est une FABRIQUE
 * (`({ strapi }) => ({ register, callback… })`) que Strapi appelle plus tard : lui affecter une propriété ne
 * change rien et ne lève aucune erreur. Cette fonction enveloppe la fabrique, ce qui est la seule façon
 * d'ajouter un comportement à une de ses actions.
 */

type Handler = (ctx: never) => Promise<unknown>;
export type ControllerFactory<Deps> = (deps: Deps) => Record<string, Handler>;

/** Exécute `extend` après l'action `action` du controller, avec la même requête (donc la même réponse à compléter). */
export function afterAction<Deps, Ctx>(
  factory: ControllerFactory<Deps>,
  action: string,
  extend: (deps: Deps, ctx: Ctx) => Promise<void>
): ControllerFactory<Deps> {
  return (deps) => {
    const controller = factory(deps);
    const original = controller[action] as unknown as (ctx: Ctx) => Promise<unknown>;
    if (typeof original !== 'function') throw new Error(`Controller action "${action}" not found`);
    return {
      ...controller,
      [action]: async (ctx: Ctx) => {
        const result = await original(ctx);
        await extend(deps, ctx);
        return result;
      },
    } as Record<string, Handler>;
  };
}
