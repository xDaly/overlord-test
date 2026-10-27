import type { Core } from '@strapi/strapi';

/** Ce qu'une policy reçoit : l'utilisateur authentifié par Users & Permissions et l'identifiant de l'URL. */
export type PolicyContext = {
  state: { user?: { id: number } | null };
  params: { id?: string };
};

/** Configuration d'une policy de propriété : le type de contenu visé et la relation qui désigne son propriétaire. */
export type OwnershipConfig = { uid: string; ownerField?: string };

export type PolicyDeps = { strapi: Core.Strapi };

export type Ownership = { found: false } | { found: true; ownerId: number | undefined };

/**
 * Cherche le propriétaire d'un document par son `documentId` (Document Service API de Strapi v5).
 * Un document absent n'est pas un refus : la route répond alors 404 elle-même, sans révéler quoi que ce soit.
 */
export async function findOwnership(
  strapi: Core.Strapi,
  { uid, ownerField = 'author' }: OwnershipConfig,
  documentId: string | undefined
): Promise<Ownership> {
  if (!documentId) return { found: false };
  const documents = strapi.documents as unknown as (uid: string) => {
    findOne(params: { documentId: string; fields: string[]; populate: Record<string, unknown> }): Promise<Record<string, unknown> | null>;
  };
  const entry = await documents(uid).findOne({ documentId, fields: ['id'], populate: { [ownerField]: { fields: ['id'] } } });
  if (!entry) return { found: false };
  const owner = entry[ownerField] as { id?: number } | null | undefined;
  return { found: true, ownerId: owner?.id };
}
