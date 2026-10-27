import type { Core } from '@strapi/strapi';

import { diffPermissions } from '../utils/auth-rules';

const crud = (uid: string, actions: string[]) => actions.map((action) => `${uid}.${action}`);

/**
 * Permissions Users & Permissions des routes `api::*`, source de vérité versionnée.
 * - public : aucune écriture ni lecture anonyme ; le front lit côté serveur avec un jeton d'API en lecture seule.
 * - authenticated : lecture, et écriture sur ses propres contenus (propriété contrôlée dans les controllers).
 * Les autres permissions des plugins (connexion, inscription, profil) gardent leurs valeurs par défaut.
 */
export const API_PERMISSIONS: Record<string, string[]> = {
  public: [],
  authenticated: [
    ...crud('api::category.category', ['find', 'findOne']),
    ...crud('api::discussion.discussion', ['find', 'findOne', 'create', 'update', 'delete', 'useful', 'follow', 'vote']),
    ...crud('api::reply.reply', ['find', 'findOne', 'create', 'update', 'delete', 'useful']),
    ...crud('api::blog-post.blog-post', ['find', 'findOne', 'create', 'update', 'delete', 'useful']),
    ...crud('api::blog-comment.blog-comment', ['find', 'findOne', 'create', 'delete', 'useful']),
    ...crud('api::event.event', ['find', 'findOne', 'rsvp']),
    // Ses propres notifications uniquement (filtre imposé par le controller) ; Strapi seul les crée.
    ...crud('api::notification.notification', ['find', 'read', 'readAll']),
    // Lecture des profils : Strapi l'exige pour relier ou charger l'auteur d'une publication ; la réponse est réduite aux champs publics.
    // Modification de son propre profil et de son avatar : routes dédiées, limitées au membre connecté.
    ...crud('plugin::users-permissions.user', ['find', 'findOne', 'updateMe', 'updateAvatar', 'removeAvatar']),
  ],
};

const MANAGED_PLUGIN_ACTIONS = crud('plugin::users-permissions.user', ['find', 'findOne', 'updateMe', 'updateAvatar', 'removeAvatar']);

const isManaged = (action: string) => action.startsWith('api::') || MANAGED_PLUGIN_ACTIONS.includes(action);

const ROLE = 'plugin::users-permissions.role';
const PERMISSION = 'plugin::users-permissions.permission';

export async function syncApiPermissions(strapi: Core.Strapi) {
  for (const [type, desired] of Object.entries(API_PERMISSIONS)) {
    const role = await strapi.db.query(ROLE).findOne({ where: { type } });
    if (!role) continue;

    const existing = (
      (await strapi.db.query(PERMISSION).findMany({ where: { role: role.id } })) as { id: number; action: string }[]
    ).filter((permission) => isManaged(permission.action));
    const { toCreate, toDelete } = diffPermissions(
      existing.map((permission) => permission.action),
      desired
    );

    for (const action of toCreate) await strapi.db.query(PERMISSION).create({ data: { action, role: role.id } });
    for (const permission of existing) {
      if (toDelete.includes(permission.action)) await strapi.db.query(PERMISSION).delete({ where: { id: permission.id } });
    }

    if (toCreate.length || toDelete.length) {
      strapi.log.info(`[auth] ${type}: +${toCreate.length} -${toDelete.length} permissions`);
    }
  }
}
