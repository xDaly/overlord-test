/**
 * Notifications du membre connecté : il les lit et les marque comme lues ; Strapi seul les crée.
 * La propriété est contrôlée dans le controller (filtre sur le destinataire), qui répond 404 pour la notification
 * d'un autre membre plutôt que 403 : on ne révèle pas qu'elle existe.
 */
const authenticated = ['global::is-authenticated'];

export default {
  routes: [
    { method: 'GET', path: '/notifications', handler: 'notification.find', config: { policies: authenticated } },
    { method: 'POST', path: '/notifications/read-all', handler: 'notification.readAll', config: { policies: authenticated } },
    { method: 'POST', path: '/notifications/:id/read', handler: 'notification.read', config: { policies: authenticated } },
  ],
};
