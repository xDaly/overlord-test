/**
 * notification controller : un membre ne voit et ne modifie que ses propres notifications.
 */

import { factories } from '@strapi/strapi';

import { requireUser, toPublicAuthor } from '../../../utils/auth-rules';

const UID = 'api::notification.notification';
const LIMIT = 30;

/** Qui a agi, et où : de quoi afficher la notification et y mener. */
const POPULATE = {
  actor: { fields: ['username', 'displayName'] as ('username' | 'displayName')[] },
  discussion: { fields: ['slug'] as 'slug'[] },
  blogPost: { fields: ['documentId'] as 'documentId'[] },
};

type Row = Record<string, unknown> & { actor?: unknown };

const present = (row: Row) => ({ ...row, actor: toPublicAuthor(row.actor) });

export default factories.createCoreController(UID, ({ strapi }) => ({
  async find(ctx) {
    const user = requireUser(ctx.state.user);
    const rows = (await strapi.documents(UID).findMany({
      filters: { recipient: { id: user.id } },
      sort: ['createdAt:desc'],
      limit: LIMIT,
      populate: POPULATE,
    })) as Row[];
    ctx.body = { data: rows.map(present) };
  },

  async read(ctx) {
    const user = requireUser(ctx.state.user);
    const found = await strapi.documents(UID).findFirst({
      filters: { documentId: ctx.params.id, recipient: { id: user.id } },
    });
    /* La notification d'un autre membre est introuvable plutôt qu'interdite : on ne révèle pas qu'elle existe. */
    if (!found) return ctx.notFound();
    const updated = (await strapi.documents(UID).update({ documentId: ctx.params.id, data: { read: true }, populate: POPULATE })) as Row;
    ctx.body = { data: present(updated) };
  },

  async readAll(ctx) {
    const user = requireUser(ctx.state.user);
    await strapi.db.query(UID).updateMany({ where: { recipient: { id: user.id }, read: false }, data: { read: true } });
    ctx.body = { ok: true };
  },
}));
