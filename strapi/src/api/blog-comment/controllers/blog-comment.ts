/**
 * blog-comment controller
 */

import { factories } from '@strapi/strapi';
import { errors } from '@strapi/utils';

import { requireUser, scrubAuthors } from '../../../utils/auth-rules';
import { parseReplyContent, toggleId } from '../../../utils/discussion-rules';
import { POINTS } from '../../../utils/gamification';
import { rewards } from '../../reward/services/reward';

const { ValidationError } = errors;

const UID = 'api::blog-comment.blog-comment';
const POST = 'api::blog-post.blog-post';

type Member = { id: number; username?: string; displayName?: string | null };
type Row = {
  id: number;
  usefulBase: number;
  author?: Member | null;
  usefulBy?: Member[];
  post?: { id: number } | null;
} | null;
type PostRow = { id: number; documentId: string; title: string; author?: { id: number } | null } | null;

export default factories.createCoreController(UID, ({ strapi }) => {
  const load = (documentId: string): Promise<Row> =>
    strapi.documents(UID).findOne({
      documentId,
      populate: {
        author: { fields: ['id', 'username', 'displayName'] },
        usefulBy: { fields: ['id'] },
        post: { fields: ['id'] },
      },
    }) as Promise<Row>;

  return {
    async find(ctx) {
      return scrubAuthors(await super.find(ctx));
    },

    async findOne(ctx) {
      return scrubAuthors(await super.findOne(ctx));
    },

    /** L'auteur est le membre connecté ; l'auteur du billet et les membres cités sont prévenus. */
    async create(ctx) {
      const user = requireUser(ctx.state.user);
      const sent = (ctx.request.body?.data ?? {}) as Record<string, unknown>;
      const content = parseReplyContent(sent.content);
      const post =
        typeof sent.post === 'string'
          ? ((await strapi.documents(POST).findOne({
              documentId: sent.post,
              fields: ['id', 'documentId', 'title'],
              populate: { author: { fields: ['id'] } },
            })) as PostRow)
          : null;
      if (!post) throw new ValidationError('post must be an existing blog post');

      ctx.request.body = { data: { content, post: post.documentId, author: user.id, usefulBase: 0 } };
      ctx.query = { ...ctx.query, populate: { author: true } };
      const created = scrubAuthors(await super.create(ctx));

      const { effects } = await rewards(strapi).grant(user.id, {
        points: { amount: POINTS.blogComment, reason: 'Merci pour votre commentaire' },
      });
      if (post.author && post.author.id !== user.id) {
        await rewards(strapi).notify(post.author.id, { kind: 'reply', actor: user.id, blogPost: post.id, text: 'a commenté votre billet' });
      }
      const mentioned = await rewards(strapi).notifyMentions(content, user.id, { title: post.title, blogPost: post.id });
      return { ...created, meta: { ...created.meta, effects, mentioned } };
    },

    async delete(ctx) {
      requireUser(ctx.state.user);
      if (!(await load(ctx.params.id))) return ctx.notFound();
      return super.delete(ctx);
    },

    /** « Utile » sur un commentaire : mêmes règles que sur une discussion. */
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
          { key: `useful:blog-comment:${row.id}:${user.id}` }
        );
        if (granted) {
          await rewards(strapi).notify(row.author.id, {
            kind: 'like',
            actor: user.id,
            blogPost: row.post?.id,
            text: 'a trouvé votre commentaire utile',
          });
          rewardedAuthor = row.author.displayName || row.author.username || null;
        }
      }
      ctx.body = { liked: active, likes: row.usefulBase + ids.length, authorUsername: row.author?.username ?? '', rewardedAuthor };
    },
  };
});
