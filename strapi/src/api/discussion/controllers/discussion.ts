/**
 * discussion controller
 */

import { factories } from '@strapi/strapi';

import {
  DISCUSSION_EDITABLE,
  pickEditable,
  requireUser,
  scrubAuthors,
} from '../../../utils/auth-rules';
import { castVote, parseNewDiscussion, slugify, toggleId, uniqueSlug, type PollVotes } from '../../../utils/discussion-rules';
import { POINTS } from '../../../utils/gamification';
import { rewards } from '../../reward/services/reward';

const UID = 'api::discussion.discussion';

const REASONS = { question: 'Question publiée', poll: 'Sondage publié', discussion: 'Discussion publiée' } as const;

type Member = { id: number };
type Row = {
  id: number;
  title: string;
  usefulBase: number;
  author?: (Member & { username?: string; displayName?: string | null }) | null;
  usefulBy?: Member[];
  followedBy?: Member[];
  pollOptions?: string[] | null;
  pollVotes?: PollVotes | null;
} | null;

export default factories.createCoreController(UID, ({ strapi }) => {
  const load = (documentId: string): Promise<Row> =>
    strapi.documents(UID).findOne({
      documentId,
      populate: {
        author: { fields: ['id', 'username', 'displayName'] },
        usefulBy: { fields: ['id'] },
        followedBy: { fields: ['id'] },
      },
    }) as Promise<Row>;

  return {
    async find(ctx) {
      return scrubAuthors(await super.find(ctx));
    },

    async findOne(ctx) {
      return scrubAuthors(await super.findOne(ctx));
    },

    /** L'auteur et l'adresse sont décidés ici ; les règles du titre, du type et du sondage valent pour tous les fronts. */
    async create(ctx) {
      const user = requireUser(ctx.state.user);
      const data = parseNewDiscussion(ctx.request.body?.data);
      const slug = await uniqueSlug(slugify(data.title), async (candidate) =>
        Boolean(await strapi.documents(UID).findFirst({ filters: { slug: candidate } }))
      );
      /* L'auteur suit sa propre discussion : il est prévenu des réponses. */
      ctx.request.body = { data: { ...data, slug, author: user.id, followedBy: [user.id] } };
      ctx.query = { ...ctx.query, populate: { author: true, category: true } };
      const created = scrubAuthors(await super.create(ctx));
      const { effects } = await rewards(strapi).grant(user.id, {
        stats: { topics: 1 },
        points: { amount: POINTS.discussion, reason: REASONS[data.type] },
        badges: data.type === 'poll' ? ['sondeur'] : [],
      });
      return { ...created, meta: { ...created.meta, effects } };
    },

    async update(ctx) {
      requireUser(ctx.state.user);
      if (!(await load(ctx.params.id))) return ctx.notFound();
      ctx.request.body = { data: pickEditable(ctx.request.body?.data, DISCUSSION_EDITABLE) };
      return scrubAuthors(await super.update(ctx));
    },

    async delete(ctx) {
      requireUser(ctx.state.user);
      if (!(await load(ctx.params.id))) return ctx.notFound();
      /* Les réponses n'ont de sens que dans leur discussion : elles partent avec elle. */
      await strapi.db.query('api::reply.reply').deleteMany({ where: { discussion: { documentId: ctx.params.id } } });
      return super.delete(ctx);
    },

    /**
     * « Utile » : un clic ajoute la voix, le suivant la retire. On ne vote pas pour soi.
     * L'auteur gagne ses points au premier « Utile » de chaque membre, jamais deux fois.
     */
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
          { key: `useful:discussion:${row.id}:${user.id}` }
        );
        if (granted) {
          await rewards(strapi).notify(row.author.id, { kind: 'like', actor: user.id, discussion: row.id, text: 'a trouvé votre message utile' });
          rewardedAuthor = row.author.displayName || row.author.username || null;
        }
      }
      ctx.body = { liked: active, likes: row.usefulBase + ids.length, authorUsername: row.author?.username ?? '', rewardedAuthor };
    },

    async follow(ctx) {
      const user = requireUser(ctx.state.user);
      const row = await load(ctx.params.id);
      if (!row) return ctx.notFound();
      const { ids, active } = toggleId((row.followedBy ?? []).map((member) => member.id), user.id);
      await strapi.documents(UID).update({ documentId: ctx.params.id, data: { followedBy: { set: ids } } });
      ctx.body = { followed: active };
    },

    async vote(ctx) {
      const user = requireUser(ctx.state.user);
      const row = await load(ctx.params.id);
      if (!row) return ctx.notFound();
      const { votes, first } = castVote(row.pollVotes ?? null, user.id, ctx.request.body?.option, row.pollOptions?.length ?? 0);
      await strapi.documents(UID).update({ documentId: ctx.params.id, data: { pollVotes: votes } });
      const effects = first
        ? (await rewards(strapi).grant(user.id, { stats: { votes: 1 }, points: { amount: POINTS.vote, reason: 'Merci pour votre vote' } })).effects
        : [];
      ctx.body = { first, counts: votes.counts, effects };
    },
  };
});
