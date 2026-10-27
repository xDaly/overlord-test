/**
 * Action d'un membre sur un rendez-vous : s'inscrire ou se désinscrire.
 */
export default {
  routes: [{ method: 'POST', path: '/events/:id/rsvp', handler: 'event.rsvp', config: { policies: ['global::is-authenticated'] } }],
};
