/**
 * Action d'un membre sur un commentaire : « Utile », jamais sur le sien.
 */
export default {
  routes: [
    {
      method: 'POST',
      path: '/blog-comments/:id/useful',
      handler: 'blog-comment.useful',
      config: {
        policies: [
          'global::is-authenticated',
          { name: 'global::is-not-owner', config: { uid: 'api::blog-comment.blog-comment', ownerField: 'author' } },
        ],
      },
    },
  ],
};
