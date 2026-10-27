/**
 * Action d'un membre sur une réponse : « Utile », jamais sur la sienne.
 */
export default {
  routes: [
    {
      method: 'POST',
      path: '/replies/:id/useful',
      handler: 'reply.useful',
      config: {
        policies: ['global::is-authenticated', { name: 'global::is-not-owner', config: { uid: 'api::reply.reply', ownerField: 'author' } }],
      },
    },
  ],
};
