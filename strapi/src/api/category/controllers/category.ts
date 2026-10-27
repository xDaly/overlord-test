/**
 * category controller
 */

import { factories } from '@strapi/strapi';

const UID = 'api::category.category';

type Entry = { id: number };
type Counter = { withCounts<T extends Entry>(entries: T[]): Promise<T[]> };

/** Les espaces sont renvoyés avec leurs compteurs : le front n'a pas à charger toutes les discussions pour les afficher. */
export default factories.createCoreController(UID, ({ strapi }) => {
  const counter = () => strapi.service(UID) as unknown as Counter;

  return {
    async find(ctx) {
      const result = (await super.find(ctx)) as { data: Entry[]; meta: unknown };
      return { ...result, data: await counter().withCounts(result.data) };
    },

    async findOne(ctx) {
      const result = (await super.findOne(ctx)) as { data: Entry | null; meta: unknown } | undefined;
      if (!result?.data) return result;
      const [data] = await counter().withCounts([result.data]);
      return { ...result, data };
    },
  };
});
