/**
 * category service
 */

import { factories } from '@strapi/strapi';

const UID = 'api::category.category';

export type CategoryCounts = { discussionsCount: number; repliesCount: number };

export default factories.createCoreService(UID, ({ strapi }) => ({
  /** Nombre de discussions et de réponses de chaque espace, comptés en base plutôt que chargés. */
  async withCounts<T extends { id: number }>(entries: T[]): Promise<(T & CategoryCounts)[]> {
    return Promise.all(
      entries.map(async (entry) => {
        const [discussionsCount, repliesCount] = await Promise.all([
          strapi.db.query('api::discussion.discussion').count({ where: { category: { id: entry.id } } }),
          strapi.db.query('api::reply.reply').count({ where: { discussion: { category: { id: entry.id } } } }),
        ]);
        return { ...entry, discussionsCount, repliesCount };
      })
    );
  },
}));
