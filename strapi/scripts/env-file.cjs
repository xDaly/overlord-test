'use strict';

const fs = require('node:fs');
const path = require('node:path');

/** L'unique fichier de configuration du dépôt, à la racine. */
const ENV_FILE = path.resolve(__dirname, '../../.env');

/** Fixe une variable dans le .env de la racine : remplace sa ligne, ou l'ajoute, sans toucher au reste. */
function setEnvValue(key, value) {
  const content = fs.existsSync(ENV_FILE) ? fs.readFileSync(ENV_FILE, 'utf8') : '';
  const line = `${key}=${value}`;
  const pattern = new RegExp(`^${key}=.*$`, 'm');
  fs.writeFileSync(ENV_FILE, pattern.test(content) ? content.replace(pattern, line) : `${content.trimEnd()}\n${line}\n`);
}

module.exports = { ENV_FILE, setEnvValue };
