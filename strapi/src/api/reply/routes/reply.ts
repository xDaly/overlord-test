/**
 * reply router : l'auteur de la réponse la supprime ; la modification suit une règle par champ
 * (texte pour l'auteur de la réponse, meilleure réponse pour l'auteur de la discussion), appliquée dans le controller.
 */

import { factories } from '@strapi/strapi';

const authenticated = 'global::is-authenticated';
const owner = { name: 'global::is-owner', config: { uid: 'api::reply.reply', ownerField: 'author' } };

export default factories.createCoreRouter('api::reply.reply', {
  config: {
    create: { policies: [authenticated] },
    update: { policies: [authenticated] },
    delete: { policies: [authenticated, owner] },
  },
});
