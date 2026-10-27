/**
 * event router : les rendez-vous sont programmés dans l'administration ; les membres les lisent.
 */

import { factories } from '@strapi/strapi';

export default factories.createCoreRouter('api::event.event', { only: ['find', 'findOne'] });
