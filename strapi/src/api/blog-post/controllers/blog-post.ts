/**
 * blog-post controller
 */

import { factories } from '@strapi/strapi';
import { errors } from '@strapi/utils';

import { requireUser, scrubAuthors } from '../../../utils/auth-rules';
import { parseNewBlogPost } from '../../../utils/blog-rules';
import { toggleId } from '../../../utils/discussion-rules';
import { POINTS } from '../../../utils/gamification';
import { rewards } from '../../reward/services/reward';

const { ValidationError } = errors;

const UID = 'api::blog-post.blog-post';
const CATEGORY = 'api::category.category';

type Member = { id: number; username?: string; displayName?: string | null };
type Row = {
  id: number;
  title: string;
  content: string;
  usefulBase: number;
  author?: Member | null;
  category?: { documentId: string } | null;
  usefulBy?: Member[];
} | null;

export default factories.createCoreController(UID, ({ strapi }) => {
  const load = (documentId: string): Promise<Row> =>
    strapi.documents(UID).findOne({
      documentId,
      populate: {
        author: { fields: ['id', 'username', 'displayName'] },
        category: { fields: ['documentId'] },
        usefulBy: { fields: ['id'] },
      },
    }) as Promise<Row>;

  /** Un billet peut être rangé dans un espace existant, ou dans aucun. */
  const assertCategory = async (documentId: string | null) => {
    if (documentId && !(await strapi.documents(CATEGORY).findOne({ documentId }))) {
      throw new ValidationError('category must be an existing space');
    }
  };

  return {
    async find(ctx) {
      return scrubAuthors(await super.find(ctx));
    },

    async findOne(ctx) {
      return scrubAuthors(await super.findOne(ctx));
    },

    /** L'auteur est le membre connecté ; il gagne ses points et les membres cités sont prévenus. */
    async create(ctx) {
      const user = requireUser(ctx.state.user);
      const post = parseNewBlogPost(ctx.request.body?.data);
      await assertCategory(post.category);
      ctx.request.body = { data: { ...post, author: user.id, views: 1, usefulBase: 0 } };
      ctx.query = { ...ctx.query, populate: { author: true, category: true } };
      const created = scrubAuthors(await super.create(ctx)) as { data: { id: number }; meta: object };

      const { effects } = await rewards(strapi).grant(user.id, { points: { amount: POINTS.blogPost, reason: 'Billet publié' } });
      const mentioned = await rewards(strapi).notifyMentions(post.content, user.id, { title: post.title, blogPost: created.data.id });
      return { ...created, meta: { ...created.meta, effects, mentioned } };
    },

    /** Seul l'auteur corrige son billet, avec les mêmes règles qu'à la publication. */
    async update(ctx) {
      requireUser(ctx.state.user);
      const existing = await load(ctx.params.id);
      if (!existing) return ctx.notFound();
      const sent = (ctx.request.body?.data ?? {}) as Record<string, unknown>;
      const post = parseNewBlogPost({
        title: sent.title ?? existing.title,
        content: sent.content ?? existing.content,
        category: 'category' in sent ? sent.category : (existing.category?.documentId ?? null),
      });
      await assertCategory(post.category);
      ctx.request.body = { data: post };
      return scrubAuthors(await super.update(ctx));
    },

    async delete(ctx) {
      requireUser(ctx.state.user);
      const existing = await load(ctx.params.id);
      if (!existing) return ctx.notFound();
      /* Les commentaires n'ont de sens que sous leur billet : ils partent avec lui. */
      await strapi.db.query('api::blog-comment.blog-comment').deleteMany({ where: { post: { id: existing.id } } });
      return super.delete(ctx);
    },

    /** « Utile » sur un billet : mêmes règles que sur une discussion. */
    async useful(ctx) {
      const user = requireUser(ctx.state.user);
      const row = await load(ctx.params.id);
      if (!row) return ctx.notFound();
      const { ids, active } = toggleId((row.usefulBy ?? []).map((member) => member.id), user.id);
      await strapi.documents(UID).update({ documentId: ctx.params.id, data: { usefulBy: { set: ids } } });

      let rewardedAuthor: string | null = null;
      if (active && row.author) {
        const { granted } = await rewards(strapi).grant(
          row.author.id,
          { stats: { likes: 1 }, points: { amount: POINTS.useful, reason: 'Recevoir un « Utile »' } },
          { key: `useful:blog-post:${row.id}:${user.id}` }
        );
        if (granted) {
          await rewards(strapi).notify(row.author.id, { kind: 'like', actor: user.id, blogPost: row.id, text: 'a trouvé votre billet utile' });
          rewardedAuthor = row.author.displayName || row.author.username || null;
        }
      }
      ctx.body = { liked: active, likes: row.usefulBase + ids.length, authorUsername: row.author?.username ?? '', rewardedAuthor };
    },
  };
});
