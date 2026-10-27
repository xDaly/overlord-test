'use strict';

/**
 * Jeton d'API en lecture seule du serveur Next.js (STRAPI_API_TOKEN).
 * Il ne peut que lire : toute écriture passe par le jeton du membre connecté, jamais par celui-ci.
 */

const TOKEN_NAME = 'frontend-read';

const READ = ['find', 'findOne'];
const READ_ONLY_ACTIONS = [
  ...['api::category.category', 'api::discussion.discussion', 'api::reply.reply', 'api::blog-post.blog-post', 'api::blog-comment.blog-comment', 'api::event.event'].flatMap(
    (uid) => READ.map((action) => `${uid}.${action}`)
  ),
  // Profils publics (points, badges) : l'e-mail est retiré côté Strapi.
  ...READ.map((action) => `plugin::users-permissions.user.${action}`),
];

/**
 * Crée le jeton s'il n'existe pas encore. La clé n'est visible qu'à la création : elle est renvoyée ici une seule fois.
 * @returns {Promise<{ created: boolean, accessKey?: string }>}
 */
async function ensureReadToken(app, name = TOKEN_NAME) {
  const tokens = app.service('admin::api-token');
  if (await tokens.exists({ name })) return { created: false };
  const token = await tokens.create({
    name,
    description: 'Serveur Next.js : lecture seule des espaces, discussions, réponses, billets, rendez-vous et profils.',
    type: 'custom',
    permissions: READ_ONLY_ACTIONS,
    lifespan: null,
  });
  return { created: true, accessKey: token.accessKey };
}

module.exports = { ensureReadToken, READ_ONLY_ACTIONS, TOKEN_NAME };
