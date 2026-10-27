import { findOwnership, type OwnershipConfig, type PolicyContext, type PolicyDeps } from '../utils/ownership';

/**
 * Seul le propriétaire d'un contenu peut le modifier ou le supprimer : empêche un membre d'agir au nom d'un autre.
 *
 *   policies: [{ name: 'global::is-owner', config: { uid: 'api::discussion.discussion', ownerField: 'author' } }]
 *
 * Un document introuvable laisse passer : la route répond 404.
 */
export default async (policyContext: PolicyContext, config: OwnershipConfig, { strapi }: PolicyDeps): Promise<boolean> => {
  const user = policyContext.state.user;
  if (!user) return false;
  const ownership = await findOwnership(strapi, config, policyContext.params.id);
  return !ownership.found || ownership.ownerId === user.id;
};
