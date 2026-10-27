/**
 * blog-post router : écriture réservée aux membres, modification et suppression à l'auteur seul.
 */

import { factories } from '@strapi/strapi';

const UID = 'api::blog-post.blog-post';
const authenticated = 'global::is-authenticated';
const owner = { name: 'global::is-owner', config: { uid: UID, ownerField: 'author' } };

export default factories.createCoreRouter(UID, {
  config: {
    create: { policies: [authenticated] },
    update: { policies: [authenticated, owner] },
    delete: { policies: [authenticated, owner] },
  },
});
