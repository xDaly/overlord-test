/**
 * Actions d'un membre sur une discussion : « Utile », suivi et vote de sondage.
 * Un membre ne marque pas « Utile » sa propre discussion.
 */
const authenticated = 'global::is-authenticated';
const notOwner = { name: 'global::is-not-owner', config: { uid: 'api::discussion.discussion', ownerField: 'author' } };

export default {
  routes: [
    { method: 'POST', path: '/discussions/:id/useful', handler: 'discussion.useful', config: { policies: [authenticated, notOwner] } },
    { method: 'POST', path: '/discussions/:id/follow', handler: 'discussion.follow', config: { policies: [authenticated] } },
    { method: 'POST', path: '/discussions/:id/vote', handler: 'discussion.vote', config: { policies: [authenticated] } },
  ],
};
