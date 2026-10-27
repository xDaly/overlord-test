'use strict';

/**
 * Données de démonstration de la maquette : espaces, membres (points, badges), discussions, réponses,
 * billets, rendez-vous et notifications.
 * Relançable sans doublon : un élément déjà présent n'est pas recréé.
 *
 *   npm run seed -w strapi
 *
 * Les membres partagent un mot de passe lu dans SEED_USER_PASSWORD (généré et ajouté à .env s'il manque).
 * Le jeton d'API en lecture seule du serveur Next.js (STRAPI_API_TOKEN) est créé s'il manque et écrit dans .env.
 */

const { randomBytes } = require('node:crypto');
const path = require('node:path');
const { compileStrapi, createStrapi } = require('@strapi/strapi');

const data = require('../seed/data.json');
const { ensureReadToken } = require('./api-token.cjs');
const { setEnvValue } = require('./env-file.cjs');

const USER = 'plugin::users-permissions.user';
const CATEGORY = 'api::category.category';
const DISCUSSION = 'api::discussion.discussion';
const REPLY = 'api::reply.reply';
const BLOG_POST = 'api::blog-post.blog-post';
const BLOG_COMMENT = 'api::blog-comment.blog-comment';
const EVENT = 'api::event.event';
const NOTIFICATION = 'api::notification.notification';
const MINUTE = 60_000;
const HOUR = 3_600_000;
const REPLY_GAP = 17 * 60_000;

const emailOf = (username) => `${username.toLowerCase().replace(/[^a-z0-9]+/g, '_')}@demo.lerevenu.test`;

function sharedPassword() {
  if (process.env.SEED_USER_PASSWORD) return process.env.SEED_USER_PASSWORD;
  const generated = `${randomBytes(9).toString('base64url')}aA1`;
  setEnvValue('SEED_USER_PASSWORD', generated);
  return generated;
}

async function main() {
  const password = sharedPassword();
  const context = await compileStrapi();
  const app = await createStrapi(context).load();
  const { slugify, uniqueSlug } = require(path.join(context.distDir, 'src/utils/discussion-rules.js'));

  try {
    const categoryIds = new Map();
    for (const category of data.categories) {
      const existing = await app.documents(CATEGORY).findFirst({ filters: { slug: category.slug } });
      /* Un espace déjà présent reçoit la présentation du seed (icône, couleur, rubrique). */
      const entry = existing
        ? await app.documents(CATEGORY).update({ documentId: existing.documentId, data: category })
        : await app.documents(CATEGORY).create({ data: category });
      categoryIds.set(category.slug, entry.documentId);
    }

    const role = await app.db.query('plugin::users-permissions.role').findOne({ where: { type: 'authenticated' } });
    const users = app.plugin('users-permissions').service('user');
    const userIds = new Map();
    const created = [];
    for (const member of data.users) {
      /* Profil et gamification de la maquette ; les points du mois comptent pour le mois en cours. */
      const profile = {
        displayName: member.displayName,
        bio: member.bio,
        interests: member.interests,
        communityRole: member.communityRole,
        avatarColor: member.avatarColor,
        subscriber: member.subscriber,
        expertTitle: member.expertTitle ?? null,
        points: member.points,
        monthPoints: member.monthPoints,
        monthKey: new Date().toISOString().slice(0, 7),
        streak: member.streak,
        badges: member.badges,
        stats: member.stats,
      };
      const existing = await app.db.query(USER).findOne({ where: { username: member.username } });
      if (existing) {
        await users.edit(existing.id, { ...profile, password });
        userIds.set(member.username, existing.id);
        created.push({ username: member.username, email: existing.email, isNew: false });
      } else {
        const email = emailOf(member.username);
        const user = await users.add({
          username: member.username,
          email,
          password,
          provider: 'local',
          confirmed: true,
          blocked: false,
          role: role.id,
          ...profile,
        });
        userIds.set(member.username, user.id);
        created.push({ username: member.username, email, isNew: true });
      }
    }

    const now = Date.now();
    const discussionIds = new Map();
    let discussions = 0;
    let replies = 0;
    for (const seed of data.discussions) {
      const base = slugify(seed.title);
      const present = await app.documents(DISCUSSION).findFirst({ filters: { slug: base } });
      if (present) {
        discussionIds.set(String(seed.seedId), present.id);
        continue;
      }
      const slug = await uniqueSlug(base, async (candidate) => Boolean(await app.documents(DISCUSSION).findFirst({ filters: { slug: candidate } })));

      const createdAt = new Date(now - seed.hoursAgo * HOUR);
      const discussion = await app.documents(DISCUSSION).create({
        data: {
          title: seed.title,
          slug,
          content: seed.content,
          type: seed.type,
          category: categoryIds.get(seed.category),
          author: userIds.get(seed.author),
          pinned: seed.pinned,
          views: seed.views,
          usefulBase: seed.usefulBase,
          ...(seed.featured ? { featured: seed.featured } : {}),
          ...(seed.article ? { article: seed.article } : {}),
          ...(seed.pollOptions ? { pollOptions: seed.pollOptions, pollVotes: { counts: seed.pollCounts, voters: {} } } : {}),
        },
      });
      await app.db.query(DISCUSSION).update({ where: { id: discussion.id }, data: { createdAt, updatedAt: createdAt } });
      discussionIds.set(String(seed.seedId), discussion.id);
      discussions += 1;

      for (const [index, reply] of seed.replies.entries()) {
        const at = new Date(Math.min(now, createdAt.getTime() + (index + 1) * REPLY_GAP));
        const entry = await app.documents(REPLY).create({
          data: {
            content: reply.content,
            discussion: discussion.documentId,
            author: userIds.get(reply.author),
            isBestAnswer: reply.best,
            verified: reply.verified,
            usefulBase: reply.usefulBase,
          },
        });
        await app.db.query(REPLY).update({ where: { id: entry.id }, data: { createdAt: at, updatedAt: at } });
        replies += 1;
      }
    }

    let blogPosts = 0;
    for (const seed of data.blogPosts) {
      if (await app.documents(BLOG_POST).findFirst({ filters: { title: seed.title } })) continue;
      const createdAt = new Date(now - seed.hoursAgo * HOUR);
      const post = await app.documents(BLOG_POST).create({
        data: {
          title: seed.title,
          content: seed.content,
          author: userIds.get(seed.author),
          category: seed.category ? categoryIds.get(seed.category) : null,
          views: seed.views,
          usefulBase: seed.usefulBase,
        },
      });
      await app.db.query(BLOG_POST).update({ where: { id: post.id }, data: { createdAt, updatedAt: createdAt } });
      for (const [index, comment] of seed.comments.entries()) {
        const at = new Date(Math.min(now, createdAt.getTime() + (index + 1) * REPLY_GAP));
        const entry = await app.documents(BLOG_COMMENT).create({
          data: { content: comment.content, post: post.documentId, author: userIds.get(comment.author), usefulBase: comment.usefulBase },
        });
        await app.db.query(BLOG_COMMENT).update({ where: { id: entry.id }, data: { createdAt: at, updatedAt: at } });
      }
      blogPosts += 1;
    }

    /* Les rendez-vous sont datés par rapport au jour du seed, pour rester à venir. */
    let events = 0;
    for (const seed of data.events) {
      if (await app.documents(EVENT).findFirst({ filters: { title: seed.title } })) continue;
      const startsAt = new Date(now);
      startsAt.setDate(startsAt.getDate() + seed.daysFromNow);
      startsAt.setHours(seed.hour, seed.minute, 0, 0);
      await app.documents(EVENT).create({
        data: { title: seed.title, host: seed.host, startsAt, goingBase: seed.goingBase, category: categoryIds.get(seed.category) },
      });
      events += 1;
    }

    /* Quelques notifications d'exemple, seulement pour un membre qui n'en a encore aucune. */
    let notifications = 0;
    const hasNotifications = new Map();
    for (const seed of data.notifications) {
      const recipient = userIds.get(seed.recipient);
      if (!hasNotifications.has(recipient)) {
        hasNotifications.set(recipient, (await app.db.query(NOTIFICATION).count({ where: { recipient: { id: recipient } } })) > 0);
      }
      if (hasNotifications.get(recipient)) continue;
      const entry = await app.db.query(NOTIFICATION).create({
        data: {
          recipient,
          kind: seed.kind,
          actor: seed.actor ? userIds.get(seed.actor) : null,
          discussion: seed.discussion ? (discussionIds.get(seed.discussion) ?? null) : null,
          badge: seed.badge ?? null,
          text: seed.text,
          read: seed.read,
        },
      });
      const at = new Date(now - seed.minutesAgo * MINUTE);
      await app.db.query(NOTIFICATION).update({ where: { id: entry.id }, data: { createdAt: at, updatedAt: at } });
      notifications += 1;
    }

    const token = await ensureReadToken(app);
    if (token.created) setEnvValue('STRAPI_API_TOKEN', token.accessKey);
    console.log(token.created ? 'SEED_TOKEN created and written to .env' : 'SEED_TOKEN already present (.env unchanged)');

    console.log(
      `SEED_DONE categories=${categoryIds.size} users=${created.length} discussions=${discussions} replies=${replies} ` +
        `blogPosts=${blogPosts} events=${events} notifications=${notifications}`
    );
    console.log(`SEED_PASSWORD=${password}`);
    for (const user of created) console.log(`SEED_USER ${user.username} ${user.email}${user.isNew ? '' : ' (existing)'}`);
  } finally {
    await app.destroy();
  }
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error);
    process.exit(1);
  }
);
