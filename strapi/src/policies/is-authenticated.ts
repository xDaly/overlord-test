import type { PolicyContext } from '../utils/ownership';

/**
 * Refuse tout appel sans membre authentifié (403).
 * Les permissions Users & Permissions font déjà ce travail ; cette policy le garantit même si le rôle public
 * recevait une permission d'écriture par erreur dans l'administration.
 */
export default (policyContext: PolicyContext): boolean => Boolean(policyContext.state.user);
