import { findOwnership, type OwnershipConfig, type PolicyContext, type PolicyDeps } from '../utils/ownership';

/**
 * L'inverse de `is-owner` : on ne marque pas « Utile » son propre message, ce qui ferait gagner des points à soi-même.
 *
 *   policies: [{ name: 'global::is-not-owner', config: { uid: 'api::reply.reply', ownerField: 'author' } }]
 */
export default async (policyContext: PolicyContext, config: OwnershipConfig, { strapi }: PolicyDeps): Promise<boolean> => {
  const user = policyContext.state.user;
  if (!user) return false;
  const ownership = await findOwnership(strapi, config, policyContext.params.id);
  return !ownership.found || ownership.ownerId !== user.id;
};
