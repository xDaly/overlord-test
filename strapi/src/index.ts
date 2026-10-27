import type { Core } from '@strapi/strapi';

import { syncApiPermissions } from './bootstrap/permissions';

export default {
  /**
   * An asynchronous register function that runs before
   * your application is initialized.
   *
   * This gives you an opportunity to extend code.
   */
  register(/* { strapi }: { strapi: Core.Strapi } */) {},

  /**
   * Applique à chaque démarrage les permissions des rôles : la configuration est reproductible.
   */
  async bootstrap({ strapi }: { strapi: Core.Strapi }) {
    await syncApiPermissions(strapi);
  },
};
