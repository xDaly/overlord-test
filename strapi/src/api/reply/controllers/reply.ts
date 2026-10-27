/**
 * reply controller
 */

import { factories } from '@strapi/strapi';
import { errors } from '@strapi/utils';

import {
  authorizeReplyUpdate,
  requireUser,
  scrubAuthors,
} from '../../../utils/auth-rules';
import { parseReplyContent, toggleId } from '../../../utils/discussion-rules';
import { POINTS } from '../../../utils/gamification';
import { rewards } from '../../reward/services/reward';

const { ForbiddenError, ValidationError } = errors;

const UID = 'api::reply.reply';
const DISCUSSION = 'api::discussion.discussion';

type Member = { id: number; username?: string; displayName?: string | null };
type DiscussionRow = { id: number; documentId: string; title: string; type: string; author?: Member | null };
type ReplyRow = {
  id: number;
  isBestAnswer: boolean;
  usefulBase: number;
  author?: Member | null;
  usefulBy?: Member[];
  discussion?: DiscussionRow | null;
} | null;

const MEMBER = { fields: ['id', 'username', 'displayName'] as ('id' | 'username' | 'displayName')[] };

const nameOf = (member: Member | null | undefined) => member?.displayName || member?.username || null;

export default factories.createCoreController(UID, ({ strapi }) => {
  const load = (documentId: string): Promise<ReplyRow> =>
    strapi.documents(UID).findOne({
      documentId,
      populate: {
        author: MEMBER,
        usefulBy: { fields: ['id'] },
        discussion: { fields: ['id', 'documentId', 'title', 'type'], populate: { author: MEMBER } },
      },
    }) as Promise<ReplyRow>;

  return {
    async find(ctx) {
      return scrubAuthors(await super.find(ctx));
    },

    async findOne(ctx) {
      return scrubAuthors(await super.findOne(ctx));
    },

    /**
     * L'auteur est le membre connecté ; la réponse ne peut pas se déclarer meilleure réponse.
     * L'auteur de la discussion et les membres cités sont prévenus ; le répondant gagne ses points.
     */
    async create(ctx) {
      const user = requireUser(ctx.state.user);
      const sent = (ctx.request.body?.data ?? {}) as Record<string, unknown>;
      const content = parseReplyContent(sent.content);
      const discussion =
        typeof sent.discussion === 'string'
          ? ((await strapi.documents(DISCUSSION).findOne({
              documentId: sent.discussion,
              fields: ['id', 'documentId', 'title', 'type'],
              populate: { author: MEMBER },
            })) as DiscussionRow | null)
          : null;
      if (!discussion) throw new ValidationError('discussion must be an existing discussion');

      ctx.request.body = { data: { content, discussion: discussion.documentId, author: user.id } };
      ctx.query = { ...ctx.query, populate: { author: true } };
      const created = scrubAuthors(await super.create(ctx));

      const { effects } = await rewards(strapi).grant(user.id, {
        stats: { replies: 1 },
        points: { amount: POINTS.reply, reason: 'Merci pour votre réponse' },
      });
      if (discussion.author && discussion.author.id !== user.id) {
        await rewards(strapi).notify(discussion.author.id, {
          kind: 'reply',
          actor: user.id,
          discussion: discussion.id,
          text: discussion.type === 'question' ? 'a répondu à votre question' : 'a réagi à votre publication',
        });
      }
      const mentioned = await rewards(strapi).notifyMentions(content, user.id, { title: discussion.title, discussion: discussion.id });
      return { ...created, meta: { ...created.meta, effects, mentioned } };
    },

    async update(ctx) {
      const user = requireUser(ctx.state.user);
      const existing = await load(ctx.params.id);
      if (!existing) return ctx.notFound();
      const editable = authorizeReplyUpdate({
        authorId: existing.author?.id,
        discussionAuthorId: existing.discussion?.author?.id,
        user,
        data: ctx.request.body?.data,
      });
      if ('content' in editable) editable.content = parseReplyContent(editable.content);
      if ('isBestAnswer' in editable && existing.discussion?.type !== 'question') {
        throw new ForbiddenError('Only a question has a best answer');
      }
      ctx.request.body = { data: editable };
      const result = scrubAuthors(await super.update(ctx));

      const chosen = editable.isBestAnswer === true && !existing.isBestAnswer && existing.discussion;
      if (chosen) {
        /* Une discussion n'a qu'une meilleure réponse : choisir celle-ci retire la précédente. */
        await strapi.db.query(UID).updateMany({
          where: { discussion: { documentId: existing.discussion!.documentId }, documentId: { $ne: ctx.params.id } },
          data: { isBestAnswer: false },
        });
        if (existing.author && existing.author.id !== user.id) {
          const { granted } = await rewards(strapi).grant(
            existing.author.id,
            { stats: { solutions: 1 }, points: { amount: POINTS.solution, reason: 'Meilleure réponse' } },
            { key: `solution:${existing.id}` }
          );
          if (granted) {
            await rewards(strapi).notify(existing.author.id, {
              kind: 'solution',
              actor: user.id,
              discussion: existing.discussion!.id,
              text: 'a choisi votre réponse comme meilleure réponse',
            });
          }
        }
      }
      return { ...result, meta: { ...result.meta, answerer: chosen ? nameOf(existing.author) : null, points: chosen ? POINTS.solution : 0 } };
    },

    async delete(ctx) {
      requireUser(ctx.state.user);
      if (!(await load(ctx.params.id))) return ctx.notFound();
      return super.delete(ctx);
    },

    /** « Utile » sur une réponse : mêmes règles que sur une discussion. */
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
          { key: `useful:reply:${row.id}:${user.id}` }
        );
        if (granted) {
          await rewards(strapi).notify(row.author.id, {
            kind: 'like',
            actor: user.id,
            discussion: row.discussion?.id,
            text: 'a trouvé votre réponse utile',
          });
          rewardedAuthor = nameOf(row.author);
        }
      }
      ctx.body = { liked: active, likes: row.usefulBase + ids.length, authorUsername: row.author?.username ?? '', rewardedAuthor };
    },
  };
});
