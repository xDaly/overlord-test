'use strict';

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { Client } = require('pg');

const ROOT = path.resolve(__dirname, '..');
const DUMP = path.join(ROOT, 'database', 'lerevenu.sql');
const STRAPI_DIR = path.join(ROOT, 'strapi');
const flags = new Set(process.argv.slice(2));
const force = flags.has('--force');
const withToken = !flags.has('--no-token');

const REQUIRED = ['DATABASE_HOST', 'DATABASE_PORT', 'DATABASE_NAME', 'DATABASE_USERNAME', 'DATABASE_PASSWORD'];

function fail(message) {
  console.error(`\nERREUR : ${message}`);
  process.exit(1);
}

function connection(database) {
  return new Client({
    host: process.env.DATABASE_HOST,
    port: Number(process.env.DATABASE_PORT),
    user: process.env.DATABASE_USERNAME,
    password: process.env.DATABASE_PASSWORD,
    database,
    ssl: process.env.DATABASE_SSL === 'true' ? { rejectUnauthorized: false } : false,
  });
}

async function ensureDatabase(name) {
  const admin = connection('postgres');
  await admin.connect();
  try {
    const found = await admin.query('select 1 from pg_database where datname = $1', [name]);
    if (found.rowCount > 0) return false;
    await admin.query(`create database "${name}"`);
    return true;
  } finally {
    await admin.end();
  }
}

async function main() {
  const missing = REQUIRED.filter((key) => !process.env[key]);
  if (missing.length) fail(`variables absentes du .env : ${missing.join(', ')}. Voir « Le fichier .env » dans le README.`);
  const name = process.env.DATABASE_NAME;
  if (!/^[A-Za-z0-9_]+$/.test(name)) fail(`DATABASE_NAME ne doit contenir que des lettres, chiffres et « _ » (reçu : ${name}).`);
  if (!fs.existsSync(DUMP)) fail(`dump introuvable : ${DUMP}`);

  console.log(`Base cible : ${name} sur ${process.env.DATABASE_HOST}:${process.env.DATABASE_PORT}`);

  let created;
  try {
    created = await ensureDatabase(name);
  } catch (error) {
    fail(`connexion à PostgreSQL impossible (${error.message}). Le conteneur est-il démarré ? (docker compose up -d postgres)`);
  }
  console.log(created ? `Base « ${name} » créée.` : `Base « ${name} » déjà présente.`);

  const client = connection(name);
  await client.connect();
  try {
    const existing = Number((await client.query("select count(*) from information_schema.tables where table_schema = 'public'")).rows[0].count);
    if (existing > 0 && !force) {
      fail(
        `la base « ${name} » contient déjà ${existing} tables, rien n'a été modifié.\n` +
          `  - pour la REMPLACER par le dump : npm run db:restore -- --force\n` +
          `  - pour garder l'existante et charger le dump dans une NOUVELLE base : changer DATABASE_NAME (et POSTGRES_DB) dans .env, puis relancer.`
      );
    }

    console.log(`Chargement de ${path.relative(ROOT, DUMP)} (${Math.round(fs.statSync(DUMP).size / 1024)} Ko)...`);
    const sql = fs.readFileSync(DUMP, 'utf8');
    await client.query('begin');
    try {
      if (existing > 0) await client.query('drop schema public cascade; create schema public;');
      await client.query(sql);
      await client.query('commit');
    } catch (error) {
      await client.query('rollback');
      fail(`le chargement a échoué et a été annulé (${error.message}).`);
    }

    await client.query('set search_path to public');
    const count = async (table) => Number((await client.query(`select count(*) from public.${table}`)).rows[0].count);
    const tables = Number((await client.query("select count(*) from information_schema.tables where table_schema = 'public'")).rows[0].count);
    console.log(
      `Dump chargé : ${tables} tables, ${await count('up_users')} comptes, ${await count('discussions')} discussions, ` +
        `${await count('replies')} réponses, ${await count('blog_posts')} billets, ${await count('events')} rendez-vous.`
    );
  } finally {
    await client.end();
  }

  if (!withToken) {
    console.log("\nPrêt. Il reste à créer le jeton d'API en lecture seule : npm run token -w strapi");
    return;
  }

  console.log("\nCréation du jeton d'API en lecture seule (STRAPI_API_TOKEN)...");
  const token = spawnSync(process.execPath, ['scripts/token.cjs'], { cwd: STRAPI_DIR, stdio: 'inherit', env: process.env });
  if (token.status !== 0) {
    fail("le dump est chargé, mais le jeton n'a pas pu être créé. Arrêter `npm run dev:strapi` s'il tourne, puis lancer : npm run token -w strapi");
  }
  console.log('\nTerminé. Lancer : npm run dev:strapi   puis   npm run dev:frontend');
}

main().catch((error) => fail(error.message));
