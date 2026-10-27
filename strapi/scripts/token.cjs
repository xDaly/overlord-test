'use strict';

/**
 * Crée le jeton d'API en lecture seule du serveur Next.js (STRAPI_API_TOKEN) s'il manque, et l'écrit dans .env.
 * Ne touche à aucune donnée : à lancer après la restauration du dump, qui ne contient aucun jeton
 * (un jeton est lié aux secrets du .env qui l'a créé).
 *
 *   npm run token -w strapi
 */

const { compileStrapi, createStrapi } = require('@strapi/strapi');
const { ensureReadToken } = require('./api-token.cjs');
const { setEnvValue } = require('./env-file.cjs');

async function main() {
  const app = await createStrapi(await compileStrapi()).load();
  try {
    const token = await ensureReadToken(app);
    if (token.created) {
      setEnvValue('STRAPI_API_TOKEN', token.accessKey);
      console.log('TOKEN created and written to .env (STRAPI_API_TOKEN)');
    } else {
      console.log('TOKEN already present in Strapi: if STRAPI_API_TOKEN is missing from .env, delete the "frontend-read" token in the admin (Settings > API Tokens) and run this again.');
    }
  } finally {
    await app.destroy();
  }
}

main().then(
  () => process.exit(0),
  (error) => {
    console.error(error);
    process.exit(1);
  }
);
