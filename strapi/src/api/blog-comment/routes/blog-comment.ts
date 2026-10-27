/**
 * blog-comment router : un commentaire se lit, se publie, se supprime (par son auteur) ; il ne se modifie pas.
 */

import { factories } from '@strapi/strapi';

const UID = 'api::blog-comment.blog-comment';
const authenticated = 'global::is-authenticated';
const owner = { name: 'global::is-owner', config: { uid: UID, ownerField: 'author' } };

export default factories.createCoreRouter(UID, {
  only: ['find', 'findOne', 'create', 'delete'],
  config: {
    create: { policies: [authenticated] },
    delete: { policies: [authenticated, owner] },
  },
});
