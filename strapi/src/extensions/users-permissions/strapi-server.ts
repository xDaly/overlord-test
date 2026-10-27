import type { Core } from '@strapi/strapi';

import { requireUser, toPublicAuthor } from '../../utils/auth-rules';
import { afterAction, type ControllerFactory } from '../../utils/controller-extension';
import { assertAvatarFile, parseProfileUpdate, toOwnProfile } from '../../utils/profile-rules';
import { POINTS } from '../../utils/gamification';
import { rewards } from '../../api/reward/services/reward';

const USER = 'plugin::users-permissions.user';

type Ctx = {
  body: unknown;
  state: { user?: { id: number } };
  request: { body?: unknown; files?: Record<string, UploadedFile | UploadedFile[]> };
};
type Handler = (ctx: Ctx) => Promise<void>;
type UploadedFile = { mimetype?: string; size?: number };
type Route = { method: string; path: string; handler: string; config: { prefix: string } };
type Plugin = {
  /* `user` est un objet ; `auth` est une fabrique appelée plus tard par Strapi (voir utils/controller-extension.ts). */
  controllers: { user: Record<string, Handler>; auth: ControllerFactory<{ strapi: Core.Strapi }> };
  routes: { 'content-api': { routes: Route[] } };
};

/**
 * - Les listes et fiches d'utilisateurs servent de profils publics : jamais l'e-mail d'un autre membre.
 * - `/users/me` renvoie le profil complet du membre connecté, avatar compris.
 * - Le profil et l'avatar se modifient par des routes réservées au membre connecté : les routes natives
 *   `PUT /users/:id` et `POST /upload` laisseraient n'importe quel membre modifier un autre compte.
 */
export default (plugin: Plugin) => {
  const { find, findOne, me } = plugin.controllers.user;
  const strapi = (globalThis as unknown as { strapi: Core.Strapi }).strapi;

  const loadProfile = async (id: number) =>
    toOwnProfile(
      (await strapi.db.query(USER).findOne({ where: { id }, populate: { avatar: true } })) as Record<string, unknown>
    );

  plugin.controllers.user.find = async (ctx) => {
    await find(ctx);
    if (Array.isArray(ctx.body)) ctx.body = ctx.body.map(toPublicAuthor);
  };

  plugin.controllers.user.findOne = async (ctx) => {
    await findOne(ctx);
    ctx.body = toPublicAuthor(ctx.body);
  };

  plugin.controllers.user.me = async (ctx) => {
    await me(ctx);
    const user = ctx.state.user;
    if (user && ctx.body) ctx.body = { ...(ctx.body as object), ...(await loadProfile(user.id)) };
  };

  /**
   * Un nouveau membre reçoit ses points et son badge de bienvenue ; le front affiche les effets renvoyés.
   * `auth` est une fabrique : on l'enveloppe, on ne lui affecte pas de propriété (Strapi l'ignorerait).
   */
  plugin.controllers.auth = afterAction<{ strapi: Core.Strapi }, Ctx>(plugin.controllers.auth, 'register', async ({ strapi: app }, ctx) => {
    const body = ctx.body as { user?: { id?: number } } | undefined;
    if (!body?.user?.id) return;
    const { effects } = await rewards(app).grant(
      body.user.id,
      { points: { amount: POINTS.welcome, reason: 'Bienvenue dans la communauté !' }, badges: ['bienvenue'] },
      { key: `welcome:${body.user.id}` }
    );
    ctx.body = { ...body, effects };
  });

  plugin.controllers.user.updateMe = async (ctx) => {
    const user = requireUser(ctx.state.user);
    await strapi.db.query(USER).update({ where: { id: user.id }, data: parseProfileUpdate(ctx.request.body) });
    ctx.body = await loadProfile(user.id);
  };

  plugin.controllers.user.updateAvatar = async (ctx) => {
    const user = requireUser(ctx.state.user);
    const sent = ctx.request.files?.files;
    const file = Array.isArray(sent) ? sent[0] : sent;
    assertAvatarFile(file);

    const upload = strapi.plugin('upload').service('upload');
    const previous = (await strapi.db.query(USER).findOne({ where: { id: user.id }, populate: { avatar: true } }))?.avatar;
    const [uploaded] = await upload.upload({ data: { fileInfo: { name: `avatar-${user.id}` } }, files: file });
    await strapi.db.query(USER).update({ where: { id: user.id }, data: { avatar: uploaded.id } });
    if (previous) await upload.remove(previous);
    ctx.body = await loadProfile(user.id);
  };

  plugin.controllers.user.removeAvatar = async (ctx) => {
    const user = requireUser(ctx.state.user);
    const upload = strapi.plugin('upload').service('upload');
    const previous = (await strapi.db.query(USER).findOne({ where: { id: user.id }, populate: { avatar: true } }))?.avatar;
    await strapi.db.query(USER).update({ where: { id: user.id }, data: { avatar: null } });
    if (previous) await upload.remove(previous);
    ctx.body = await loadProfile(user.id);
  };

  /* Placées avant `/users/:id`, sinon « me » serait lu comme un identifiant. */
  plugin.routes['content-api'].routes.unshift(
    { method: 'PUT', path: '/users/me', handler: 'user.updateMe', config: { prefix: '' } },
    { method: 'POST', path: '/users/me/avatar', handler: 'user.updateAvatar', config: { prefix: '' } },
    { method: 'DELETE', path: '/users/me/avatar', handler: 'user.removeAvatar', config: { prefix: '' } }
  );

  return plugin;
};
