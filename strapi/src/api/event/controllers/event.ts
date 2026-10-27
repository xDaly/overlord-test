/**
 * event controller
 */

import { factories } from '@strapi/strapi';

import { requireUser, scrubAuthors } from '../../../utils/auth-rules';
import { toggleId } from '../../../utils/discussion-rules';

const UID = 'api::event.event';

export default factories.createCoreController(UID, ({ strapi }) => ({
  async find(ctx) {
    return scrubAuthors(await super.find(ctx));
  },

  async findOne(ctx) {
    return scrubAuthors(await super.findOne(ctx));
  },

  /** S'inscrire à un rendez-vous, ou se désinscrire au second clic. */
  async rsvp(ctx) {
    const user = requireUser(ctx.state.user);
    const event = (await strapi.documents(UID).findOne({
      documentId: ctx.params.id,
      populate: { attendees: { fields: ['id'] } },
    })) as { goingBase: number; attendees?: { id: number }[] } | null;
    if (!event) return ctx.notFound();
    const { ids, active } = toggleId((event.attendees ?? []).map((member) => member.id), user.id);
    await strapi.documents(UID).update({ documentId: ctx.params.id, data: { attendees: { set: ids } } });
    ctx.body = { joined: active, going: event.goingBase + ids.length };
  },
}));
