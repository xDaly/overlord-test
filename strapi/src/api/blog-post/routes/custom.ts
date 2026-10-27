/**
 * Action d'un membre sur un billet : « Utile », jamais sur le sien.
 */
export default {
  routes: [
    {
      method: 'POST',
      path: '/blog-posts/:id/useful',
      handler: 'blog-post.useful',
      config: {
        policies: ['global::is-authenticated', { name: 'global::is-not-owner', config: { uid: 'api::blog-post.blog-post', ownerField: 'author' } }],
      },
    },
  ],
};
