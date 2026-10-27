/**
 * reward service : points, badges et notifications de la communauté, versés côté Strapi uniquement.
 */

import { factories, type Core } from '@strapi/strapi';

import { applyReward, BADGES, mentionedHandles, readProfile, type Effect, type RewardPlan } from '../../../utils/gamification';

const UID = 'api::reward.reward';
const USER = 'plugin::users-permissions.user';
const NOTIFICATION = 'api::notification.notification';

export type NotificationInput = {
  kind: 'reply' | 'like' | 'mention' | 'badge' | 'solution' | 'level' | 'event';
  text: string;
  actor?: number;
  discussion?: number;
  blogPost?: number;
  badge?: string;
};

/** Cible d'une mention : la discussion ou le billet où le membre a été cité. */
export type MentionTarget = { title: string; discussion?: number; blogPost?: number };

export type Mentioned = { username: string; name: string };

export type RewardService = {
  grant(userId: number, plan: RewardPlan, options?: { key?: string }): Promise<{ granted: boolean; effects: Effect[] }>;
  notify(recipientId: number, input: NotificationInput): Promise<void>;
  notifyMentions(text: string, authorId: number, target: MentionTarget): Promise<Mentioned[]>;
};

export default factories.createCoreService(UID, ({ strapi }) => {
  const notify: RewardService['notify'] = async (recipientId, input) => {
    await strapi.db.query(NOTIFICATION).create({ data: { ...input, recipient: recipientId, read: false } });
  };

  const service: RewardService = {
    notify,

    /**
     * Verse une récompense. Avec une clé, elle n'est versée qu'une fois (un « Utile » retiré puis remis ne rapporte rien).
     * Les montées de niveau et les badges deviennent aussi des notifications.
     */
    async grant(userId, plan, { key } = {}) {
      if (key && (await strapi.db.query(UID).findOne({ where: { key } }))) return { granted: false, effects: [] };

      const user = await strapi.db.query(USER).findOne({ where: { id: userId } });
      if (!user) return { granted: false, effects: [] };

      const { profile, effects } = applyReward(readProfile(user), plan, new Date());
      await strapi.db.query(USER).update({ where: { id: userId }, data: profile });
      if (plan.points || key) {
        await strapi.db.query(UID).create({
          data: { key: key ?? null, recipient: userId, points: plan.points?.amount ?? 0, reason: plan.points?.reason ?? key },
        });
      }

      for (const effect of effects) {
        if (effect.kind === 'level') await notify(userId, { kind: 'level', text: `Vous passez au niveau « ${effect.name} »` });
        if (effect.kind === 'badge') {
          await notify(userId, { kind: 'badge', badge: effect.code, text: `Nouveau badge : ${BADGES[effect.code]}` });
        }
      }
      return { granted: true, effects };
    },

    /** Prévient chaque membre cité (@pseudo) qui existe, sauf l'auteur ; renvoie leurs noms pour remercier l'auteur. */
    async notifyMentions(text, authorId, target) {
      const handles = mentionedHandles(text);
      if (handles.length === 0) return [];
      const members = (await strapi.db.query(USER).findMany({
        where: { username: { $in: handles }, id: { $ne: authorId } },
        select: ['id', 'username', 'displayName'],
      })) as { id: number; username: string; displayName?: string | null }[];

      for (const member of members) {
        await notify(member.id, {
          kind: 'mention',
          actor: authorId,
          discussion: target.discussion,
          blogPost: target.blogPost,
          text: `vous a mentionné dans « ${target.title.slice(0, 120)} »`,
        });
      }
      return members.map((member) => ({ username: member.username, name: member.displayName || member.username }));
    },
  };

  return service;
});

/** Accès typé au service depuis les controllers. */
export const rewards = (strapi: Core.Strapi) => strapi.service(UID) as unknown as RewardService;
