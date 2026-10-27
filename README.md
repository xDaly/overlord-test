# Communauté Le Revenu

Espace communautaire où les lecteurs posent des questions, échangent et partagent leurs connaissances.
Test technique « Développeur Full Stack » : **Next.js** (App Router) pour l'interface, **Strapi v5** et **PostgreSQL** pour toute la logique métier et la persistance.

- Frontend : Next.js 16, React 19, TypeScript, Tailwind CSS → <http://localhost:3000>
- Backend : Strapi 5, TypeScript, API REST, Document Service API → <http://localhost:1337>
- Base de données : PostgreSQL 16 (Docker)

## Sommaire

1. [Installation et lancement](#1-installation-et-lancement)
2. [Comptes de démonstration](#2-comptes-de-démonstration)
3. [Tests](#3-tests)
4. [Architecture](#4-architecture)
5. [Correspondance avec le sujet](#5-correspondance-avec-le-sujet)
6. [Choix, justifications et limites](#6-choix-justifications-et-limites)

## 1. Installation et lancement

**Prérequis** : Node.js 20 ou 22 (testé avec 22), npm, Docker.

```bash
# 1. Configuration : copier le modèle, puis remplacer chaque « change-me » (voir « Le fichier .env » ci-dessous)
cp .env.example .env

# 2. PostgreSQL
docker compose up -d postgres

# 3. Dépendances (monorepo npm : strapi + frontend)
npm install

# 4. Base de données : UNE des deux options (détails ci-dessous)
#    a) charger le dump fourni (recommandé pour la revue) : crée la base, charge les données, crée le jeton d'API
npm run db:restore
#    b) ou générer les données avec le seed
npm run seed -w strapi

# 5. Lancer les deux serveurs, chacun dans son terminal
npm run dev:strapi      # http://localhost:1337
npm run dev:frontend    # http://localhost:3000
```

**Option a : le dump** ([`database/lerevenu.sql`](database/lerevenu.sql)), chargé par le script [`scripts/restore-db.cjs`](scripts/restore-db.cjs).

Ce que fait `npm run db:restore`, en une commande et sans outil PostgreSQL à installer (il utilise le pilote `pg`) :

1. Lit la connexion dans le `.env` et **crée la base `DATABASE_NAME` si elle n'existe pas**.
2. Charge le dump dans **une seule transaction** : en cas d'erreur, tout est annulé et la base reste comme avant.
3. Affiche un récapitulatif (tables, comptes, discussions…).
4. Crée le **jeton d'API en lecture seule** du serveur Next.js et l'écrit dans `.env` (`STRAPI_API_TOKEN`).

Options et garde-fous :

| Commande | Effet |
| --- | --- |
| `npm run db:restore` | base neuve ou vide : charge le dump. **Une base qui contient déjà des tables n'est jamais modifiée** : le script s'arrête avec un message. |
| `npm run db:restore -- --force` | remplace le contenu de la base par le dump (revenir à l'état initial). |
| `npm run db:restore -- --no-token` | ne crée pas le jeton d'API (à faire ensuite avec `npm run token -w strapi`). |

Pour garder une base existante et charger le dump dans une **nouvelle** base, changer `DATABASE_NAME` et `POSTGRES_DB` dans le `.env`, puis relancer la commande : la base est créée.

Contenu du dump :

- Le schéma créé par Strapi et les données de démonstration : 11 espaces, **19 comptes** (voir [§2](#2-comptes-de-démonstration)), 20 discussions, 48 réponses, 5 billets, 3 rendez-vous et des notifications d'exemple.
- Il ne contient **ni compte administrateur, ni jeton d'API, ni session** : ces éléments dépendent des secrets du `.env` qui les a créés, d'où l'étape 4 ci-dessus.
- Les trois rendez-vous sont datés du 28 avril au 12 mai 2027 : l'application n'affiche que les rendez-vous à venir.
- Mot de passe de tous les comptes : voir [§2](#2-comptes-de-démonstration).
- Format : SQL texte en `INSERT` (et non en `COPY`), pour que le script puisse le jouer sans `psql`.

Régénérer le dump depuis une base de référence (le conteneur PostgreSQL doit tourner) :
`docker exec postgres sh -c 'pg_dump -U "$POSTGRES_USER" -d <base> --no-owner --no-privileges --clean --if-exists --inserts --rows-per-insert=100 --exclude-table-data="strapi_api_token*" --exclude-table-data="strapi_transfer_token*" --exclude-table-data=strapi_sessions --exclude-table-data=admin_permissions_api_token_lnk'`, puis retirer les deux lignes `\restrict` et `\unrestrict` ajoutées par les versions récentes de `pg_dump`.

**Option b : le seed** (`npm run seed -w strapi`), qui fait la même chose à partir de [`strapi/seed/data.json`](strapi/seed/data.json) :

- Strapi crée le schéma PostgreSQL à partir des Content Types.
- Les mêmes données sont chargées. Le script est **relançable** : un élément déjà présent n'est pas recréé.
- Le mot de passe commun des membres est lu dans `SEED_USER_PASSWORD` ; laissé vide, il est généré, ajouté à `.env` et affiché (`SEED_PASSWORD=…`). Pour retrouver exactement les comptes du dump, y mettre le mot de passe de la [§2](#2-comptes-de-démonstration).
- Le **jeton d'API en lecture seule** est créé dans Strapi et écrit dans `.env` (`STRAPI_API_TOKEN`).

À savoir :

- Lancer `db:restore`, le seed ou `npm run token` **avant** `npm run dev:strapi`, ou avec Strapi arrêté : l'étape du jeton recompile le dossier `dist`.
- L'administration de Strapi (<http://localhost:1337/admin>) demande de créer un compte administrateur à la première visite. Ce n'est pas nécessaire pour faire fonctionner l'application.
- Après une modification du code en développement, redémarrer `npm run dev:frontend` si un comportement paraît ne pas suivre : les adaptateurs sont mis en cache dans le processus.

### Avec Docker Compose

PostgreSQL, Strapi et Next.js peuvent aussi tourner dans des conteneurs, toujours **en mode développement**, avec le même fichier `.env` (section suivante) :

```bash
docker compose build                          # construit l'image une seule fois (long la première fois : npm ci)
docker compose up -d postgres
docker compose run --rm db-restore            # crée la base, charge le dump, crée le jeton d'API et l'écrit dans .env
docker compose up strapi frontend             # Strapi : http://localhost:1337 · Next.js : http://localhost:3000
```

- Chaque service lit le `.env` de la racine (`env_file`), et Compose s'en sert aussi pour les `${…}` de `docker-compose.yml`. Seuls les noms d'hôte changent dans le réseau Docker, et sont surchargés dans le fichier : `DATABASE_HOST=postgres` pour Strapi, `STRAPI_URL=http://strapi:1337` pour Next.js.
- `db-restore` est le même script que `npm run db:restore`, avec les mêmes options (`docker compose run --rm db-restore --force`). Il monte le `.env` et le dossier `database/` de la machine : le jeton d'API arrive donc dans le `.env` de la machine. Le lancer **avant** le service `frontend`, qui lit ce jeton à son démarrage.
- Une seule image, `lerevenu-dev` ([`Dockerfile`](Dockerfile)), sert les trois services : les dépendances et le code, sans aucune construction. Seul le service `strapi` la construit (`docker compose build`) ; `frontend` et `db-restore` la réutilisent. Après une modification du code, relancer `docker compose build`.
- Ne pas lancer en même temps `npm run dev:strapi` / `npm run dev:frontend` sur la machine : les ports 1337 et 3000 seraient pris.
- Les fichiers envoyés (avatars) vont dans `docker/uploads/`.

### Le fichier .env

Un **seul** fichier `.env`, à la racine, configure tout : PostgreSQL, Strapi et Next.js. Il n'est jamais commité (`.gitignore`). Strapi le lit grâce à `node --env-file=../.env` dans ses scripts npm ; Next.js, qui ne lit que le `.env` de son propre dossier, charge celui de la racine dans [`frontend/next.config.ts`](frontend/next.config.ts).

```ini
NODE_ENV=development
HOST=0.0.0.0
PORT=1337                       # port de Strapi (le script de Next.js le fixe à 3000)

# PostgreSQL : le conteneur lit POSTGRES_*, Strapi lit DATABASE_*
POSTGRES_DB=lerevenu
POSTGRES_USER=lerevenu
POSTGRES_PASSWORD=<mot de passe de votre choix>
DATABASE_CLIENT=postgres
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=lerevenu          # identique à POSTGRES_DB
DATABASE_USERNAME=lerevenu      # identique à POSTGRES_USER
DATABASE_PASSWORD=<identique à POSTGRES_PASSWORD>
DATABASE_SSL=false

# Secrets de Strapi : une valeur aléatoire distincte pour chacun (APP_KEYS en demande plusieurs, séparées par des virgules)
APP_KEYS=<clé1>,<clé2>,<clé3>,<clé4>
API_TOKEN_SALT=<aléatoire>
ADMIN_JWT_SECRET=<aléatoire>
TRANSFER_TOKEN_SALT=<aléatoire>
JWT_SECRET=<aléatoire>
ENCRYPTION_KEY=<aléatoire>

# Next.js (serveur uniquement, jamais de préfixe NEXT_PUBLIC_)
STRAPI_URL=http://localhost:1337
```

`STRAPI_API_TOKEN` s'ajoute tout seul au fichier quand on lance `npm run token -w strapi` ou `npm run seed -w strapi`. `SEED_USER_PASSWORD` s'ajoute avec le seed, ou se renseigne à la main (voir [§3](#3-tests)).
Pour générer une valeur aléatoire : `node -e "console.log(require('crypto').randomBytes(16).toString('base64'))"`.

| Variable | Rôle |
| --- | --- |
| `DATABASE_*`, `POSTGRES_*` | connexion de Strapi à PostgreSQL, et création de la base par le conteneur |
| `APP_KEYS`, `*_SALT`, `*_SECRET`, `ENCRYPTION_KEY` | secrets de Strapi (sessions, jetons, administration) |
| `STRAPI_URL` | adresse de Strapi pour le serveur Next.js (par défaut `http://localhost:1337`) |
| `STRAPI_API_TOKEN` | jeton d'API **en lecture seule** du serveur Next.js, créé par `npm run token` ou par le seed |
| `SEED_USER_PASSWORD` | mot de passe commun des membres de démonstration (seed) et des tests d'API ; généré par le seed s'il manque |

## 2. Comptes de démonstration

**Mot de passe de tous les comptes du dump : `LeRevenu-Demo-2026!`**

Le formulaire de connexion demande une « adresse e-mail ou identifiant » : les deux fonctionnent. Pour essayer l'application, **commencer par `Camille_B`**, un membre « actif » qui a déjà des points, des badges et des notifications.

| Identifiant | Adresse e-mail | Rôle | Points |
| --- | --- | --- | ---: |
| `Camille_B` | `camille_b@demo.lerevenu.test` | membre « actif » (points, badges, notifications) | 142 |
| `LaRedaction` | `laredaction@demo.lerevenu.test` | **rédaction** | – |
| `Moderation` | `moderation@demo.lerevenu.test` | modération | – |
| `Sandrine_CGP` | `sandrine_cgp@demo.lerevenu.test` | expert : conseillère en gestion de patrimoine | 238 |
| `Me_Garnier` | `me_garnier@demo.lerevenu.test` | expert : notaire | 175 |
| `PapyBoursier` | `papyboursier@demo.lerevenu.test` | membre | 804 |
| `Vincent_ETF` | `vincent_etf@demo.lerevenu.test` | membre | 612 |
| `Odile.Retraite` | `odile_retraite@demo.lerevenu.test` | membre | 286 |
| `Nadia.Patrimoine` | `nadia_patrimoine@demo.lerevenu.test` | membre | 197 |
| `Claire_Nantes` | `claire_nantes@demo.lerevenu.test` | membre | 166 |
| `Sophie.Invest` | `sophie_invest@demo.lerevenu.test` | membre | 151 |
| `Karim_Immo` | `karim_immo@demo.lerevenu.test` | membre | 131 |
| `Bertrand59` | `bertrand59@demo.lerevenu.test` | membre | 118 |
| `Marc_Lyon` | `marc_lyon@demo.lerevenu.test` | membre | 92 |
| `LeRentier` | `lerentier@demo.lerevenu.test` | membre | 73 |
| `Thomas_PEA` | `thomas_pea@demo.lerevenu.test` | membre | 58 |
| `Julie_Toulouse` | `julie_toulouse@demo.lerevenu.test` | membre | 44 |
| `JeuneEpargnant` | `jeuneepargnant@demo.lerevenu.test` | membre | 37 |
| `Helene_R` | `helene_r@demo.lerevenu.test` | membre | 22 |

Ces adresses sont fictives (domaine `.test`). Les points sont ceux du dump : ils évoluent quand on publie, vote ou répond.

**Pistes pour la revue**

- Connecté en `Camille_B` : publier une discussion (essayer un titre de moins de 10 caractères pour voir l'erreur), répondre, marquer « Utile » la réponse d'un autre membre, ouvrir les notifications.
- Choisir la **meilleure réponse** : seul l'auteur d'une *question* le peut. Se connecter avec l'auteur de la question pour la désigner.
- Visiteur non connecté : lecture seule ; toute publication est refusée par Strapi (403), pas seulement masquée dans l'interface.
- Strapi limite le nombre de tentatives de connexion par minute : en changeant de compte très vite, une réponse « trop de tentatives » peut apparaître. Patienter une minute.
- L'**administration** de Strapi (<http://localhost:1337/admin>) n'a pas de compte fourni : elle demande d'en créer un à la première visite, ce qui permet de parcourir les Content Types et les permissions.

## 3. Tests

```bash
npm test -w frontend          # tests unitaires du frontend (Vitest)
npm test -w strapi            # règles métier et policies de Strapi (Vitest)
npm run test:api -w strapi    # tests d'API contre un Strapi démarré (voir ci-dessous)
```

Les **tests d'API** appellent un vrai Strapi : démarrer `npm run dev:strapi`, avoir chargé la base (dump ou seed), puis les exécuter. Ils se connectent avec des comptes de démonstration : **`SEED_USER_PASSWORD` doit valoir le mot de passe de la [§2](#2-comptes-de-démonstration)** dans le `.env` (le seed le renseigne ; après une restauration du dump, l'ajouter à la main). Ils suppriment ce qu'ils créent, sauf un compte `zz_test_…` par exécution (l'API ne permet pas à un membre de supprimer son compte) ; les points versés aux membres restent aussi : relancer `npm run db:restore -- --force` pour revenir à l'état initial.

Les quatre sujets demandés par le sujet :

| Sujet | Où |
| --- | --- |
| Validation d'une discussion | [`strapi/tests/api/discussions.api.test.ts`](strapi/tests/api/discussions.api.test.ts), [`strapi/src/utils/discussion-rules.test.ts`](strapi/src/utils/discussion-rules.test.ts), [`frontend/modules/discussions/domain/discussion.rules.test.ts`](frontend/modules/discussions/domain/discussion.rules.test.ts) |
| Refus d'une publication non authentifiée | `discussions.api.test.ts` (« publication par un utilisateur non authentifié »), `replies.api.test.ts`, `community.api.test.ts` (chaque route d'écriture) |
| Protection contre l'usurpation d'auteur | `discussions.api.test.ts` et `replies.api.test.ts` (« usurpation d'auteur »), [`strapi/src/policies/policies.test.ts`](strapi/src/policies/policies.test.ts) |
| Affichage des discussions | `discussions.api.test.ts` (« affichage des discussions »), [`strapi-discussion.mapper.test.ts`](frontend/modules/discussions/infrastructure/strapi-discussion.mapper.test.ts), [`strapi-discussion.repository.test.ts`](frontend/modules/discussions/infrastructure/strapi-discussion.repository.test.ts) |

Le frontend teste aussi le client Strapi, la construction des requêtes, la pagination et le tri, l'authentification et les adaptateurs (billets, rendez-vous, notifications, membres).

## 4. Architecture

```
.
├── strapi/                      Backend
│   ├── src/api/<type>/          content-types (schema.json), controllers, services, routes
│   ├── src/policies/            is-authenticated, is-owner, is-not-owner
│   ├── src/utils/               règles métier pures, testées sans serveur
│   ├── src/bootstrap/           permissions des rôles, appliquées à chaque démarrage
│   ├── src/extensions/          Users & Permissions : profil public, avatar, inscription
│   ├── scripts/                 seed et jeton d'API
│   └── tests/api/               tests d'API
├── frontend/                    Interface
│   ├── app/(community)/         pages (App Router) : accueil, discussions, espaces, billets, profils…
│   ├── components/              composants React (community/ et ui/)
│   ├── modules/<domaine>/       domain · application · infrastructure · presentation
│   └── lib/                     client Strapi typé, construction des requêtes, erreurs
├── database/lerevenu.sql        dump PostgreSQL (schéma + données de démonstration)
├── scripts/restore-db.cjs       charge le dump dans la base du .env (npm run db:restore)
├── docker-compose.yml           postgres, strapi, frontend, db-restore (développement)
├── Dockerfile                   image de développement partagée (dépendances + code)
├── .env.example                 modèle du fichier de configuration, sans secret
└── .env                         configuration unique, non commitée (voir « Le fichier .env »)
```

### 4.1 Backend Strapi

**Modèle de données** (relations entre Content Types) :

| Entité | Champs principaux | Relations |
| --- | --- | --- |
| `User` (Users & Permissions, étendu) | username, displayName, bio, interests, avatar, points, badges, stats | discussions, replies, billets |
| `Category` | name, slug, description, icon, color | discussions |
| `Discussion` | title (≥ 10), slug, content, type (`question` / `discussion` / `poll`) | **author** (User), **category**, **replies** |
| `Reply` | content, isBestAnswer | **author** (User), **discussion** |

Le sujet demande ces quatre entités au minimum. Le projet ajoute aussi `BlogPost`, `BlogComment`, `Event`, `Notification` et `Reward` (voir [§6](#6-choix-justifications-et-limites)).

**Où vit chaque règle.** La logique métier est dans Strapi et nulle part ailleurs : Next.js ne parle jamais à PostgreSQL.

| Besoin du sujet | Mécanisme Strapi |
| --- | --- |
| Valider titre, contenu, type, catégorie | controller → `parseNewDiscussion` ([`discussion-rules.ts`](strapi/src/utils/discussion-rules.ts)) : indépendant du frontend, erreur 400 avec message |
| Interdire la publication aux non-authentifiés | permissions des rôles ([`permissions.ts`](strapi/src/bootstrap/permissions.ts)) **et** policy `global::is-authenticated` sur chaque route d'écriture |
| Empêcher de publier au nom d'un autre | le controller **impose** `author = utilisateur connecté`, quoi que le client envoie ; policy `is-owner` pour modifier ou supprimer |
| Pas de « Utile » sur son propre message | policy `is-not-owner` |
| URL propre par discussion | `slug` généré depuis le titre, rendu unique (`-2`, `-3`…) |
| Relations en une requête, tri, pagination | `populate` ciblé, `sort` et `pagination` de l'API REST de Strapi |
| Erreurs HTTP cohérentes | 400 validation · 401/403 accès · 404 introuvable, jamais de détail technique |
| Opérations métier personnalisées | **Document Service API** (`strapi.documents(uid)`) dans les controllers et services |

**Policies** (`strapi/src/policies/`), déclarées sur les routes :

- `is-authenticated` : refuse (403) tout appel sans membre authentifié, même si une permission d'écriture était donnée au rôle public par erreur.
- `is-owner` : seul le propriétaire (champ configurable, `author` par défaut) modifie ou supprime un contenu. Un document introuvable laisse passer : la route répond 404.
- `is-not-owner` : l'inverse, pour « Utile ».

```ts
// strapi/src/api/discussion/routes/discussion.ts (extrait simplifié)
factories.createCoreRouter(UID, {
  config: {
    create: { policies: ['global::is-authenticated'] },
    update: { policies: ['global::is-authenticated', { name: 'global::is-owner', config: { uid: UID } }] },
    delete: { policies: ['global::is-authenticated', { name: 'global::is-owner', config: { uid: UID } }] },
  },
});
```

**Permissions** (source de vérité versionnée, appliquée à chaque démarrage par [`permissions.ts`](strapi/src/bootstrap/permissions.ts)) :

- Rôle **public** : aucune permission. Un visiteur ne lit ni n'écrit rien directement dans Strapi.
- Rôle **authenticated** : lecture, et écriture sur ses propres contenus (la propriété est contrôlée par les policies).
- Le serveur Next.js lit avec un **jeton d'API en lecture seule** (`find`, `findOne` uniquement). Chaque écriture utilise le jeton **du membre connecté**.
- Les profils exposés ne contiennent jamais d'e-mail (`toPublicAuthor`).

### 4.2 Frontend Next.js

**Server Components par défaut.** Les pages sont des Server Components qui lisent Strapi côté serveur : le jeton d'API ne quitte jamais le serveur, aucune requête n'est exposée au navigateur, et la page arrive rendue. Les Client Components (`"use client"`) sont réservés à l'interactivité : formulaires, boutons « Utile », menus, onglets, thème.

**Récupération des données.**

- Tous les appels passent par un client unique et typé, [`lib/strapi-client.ts`](frontend/lib/strapi-client.ts), qui traduit les refus de Strapi en erreurs métier (`unauthenticated`, `forbidden`, `not-found`, `validation`, `unavailable`).
- Chaque domaine suit le même découpage : `domain` (types et règles pures) · `application` (cas d'usage) · `infrastructure` (adaptateur Strapi) · `presentation` (Server Actions).
- Aucune discussion, catégorie, billet ni membre n'est écrit en dur dans un composant : tout vient de l'API.

**Actualisation.**

- Les requêtes sont en `cache: "no-store"` et les pages lisent les cookies de session : elles sont rendues à chaque requête, donc toujours à jour.
- Les écritures passent par des **Server Actions** qui appellent Strapi avec le jeton du membre, puis `revalidatePath` pour rafraîchir les pages concernées.
- La session vit dans des cookies `httpOnly`. [`proxy.ts`](frontend/proxy.ts) renouvelle le jeton d'accès avant le rendu ; deux requêtes simultanées partagent un seul échange de renouvellement, car Strapi révoque le jeton de rafraîchissement dès qu'il sert.
- Le **tri**, la **page** et l'**onglet** vivent dans l'adresse (`?tri=`, `?ordre=`, `?page=`) : liens partageables, rendus côté serveur, filtrés par Strapi.

**États.** Chargement (`loading.tsx`), erreur (`error.tsx`), contenu introuvable (`not-found.tsx`) et liste vide (`EmptyFeed`), tous sous `frontend/app/(community)/`.

## 5. Correspondance avec le sujet

| Exigence | État |
| --- | --- |
| **A.** Discussions issues de l'API : titre, auteur, catégorie, nombre de réponses, date | ✅ |
| **A.** Filtre par catégorie, tri par date de publication, navigation vers le détail | ✅ filtre `/espaces/<slug>` · tri « Plus récentes / Plus anciennes » (`?ordre=`) |
| **B.** URL propre, contenu, auteur, date, catégorie, réponses, publication d'une réponse via Strapi | ✅ `/discussions/<slug>` |
| **C.** Formulaire (titre ≥ 10, contenu obligatoire, catégorie, type), erreurs, redirection | ✅ |
| **C.** Validations métier côté Strapi, indépendantes du frontend | ✅ |
| **D.** Auteur de chaque discussion et réponse, non-authentifiés refusés, pas d'usurpation, permissions dans Strapi | ✅ |
| **3.** User, Category, Discussion, Reply ; relations ; pagination et tri côté backend ; validation ; erreurs HTTP | ✅ |
| **3.** Controllers, services, **policies**, permissions, Document Service API | ✅ |
| **4.** Composants réutilisables, appels centralisés et typés, Server/Client Components, états de chargement/erreur/vide, responsive | ✅ |
| **5.** Recherche (`/recherche`) | ✅ |
| **5.** Votes « Utile » et meilleure réponse | ✅ |
| **5.** Pagination des discussions, profil utilisateur (`/membres/<pseudo>`) | ✅ 10 par page, `?page=` |
| **5.** Tests end-to-end Playwright | ❌ non réalisé |
| **5.** Docker Compose pour Next.js, Strapi et PostgreSQL | ✅ services `postgres`, `strapi`, `frontend` (mode développement) et `db-restore` : voir « Avec Docker Compose » |
| **6.** Tests : validation, refus non authentifié, usurpation, affichage | ✅ voir [§3](#3-tests) |
| **7.** Dépôt Git, schémas, seed, README, tests | ✅ |
| **7.** Configuration PostgreSQL et **dump** de la base | ✅ `docker-compose.yml`, [`database/lerevenu.sql`](database/lerevenu.sql), comptes en [§2](#2-comptes-de-démonstration) |
| **7.** Fichier `.env.example` sans secret | ✅ [`.env.example`](.env.example) : modèle de l'unique `.env` (non commité), documenté dans le README |

## 6. Choix, justifications et limites

**Périmètre.** Le sujet demande un périmètre cohérent plutôt que la reproduction complète de la maquette. Au-delà du cœur (discussions, réponses, catégories, utilisateurs), le projet reprend aussi de la maquette les billets de blog, les rendez-vous, les notifications et les points/badges. Tout cela vit dans Strapi, avec les mêmes règles que le cœur (policies, validation côté serveur, auteur imposé). Les points et badges sont versés **uniquement par Strapi**, jamais par le frontend ; un « Utile » ne rapporte qu'une fois par membre grâce à un registre (`Reward`).

**Pourquoi un jeton d'API en lecture seule côté serveur.** Le rôle public de Strapi n'a aucune permission : les pages sont rendues sur le serveur avec un jeton qui ne peut que lire. Le navigateur n'appelle jamais Strapi directement, et le jeton n'est jamais préfixé `NEXT_PUBLIC_`.

**Bibliothèques ajoutées** (frontend) :

| Bibliothèque | Pourquoi |
| --- | --- |
| `@base-ui/react`, `shadcn`, `class-variance-authority`, `cn`, `tw-animate-css` | composants accessibles (dialogues, menus, onglets) et variantes de style, avec Tailwind |
| `lucide-react` | icônes |
| `next-themes` | thème clair/sombre sans scintillement au chargement |
| `sonner` | notifications discrètes après une action |
| `vitest` | tests (frontend et Strapi) |

Aucune bibliothèque ajoutée côté Strapi en dehors de `pg` (PostgreSQL) et de `vitest`.

**Limites connues.**

- Pas de Playwright. Docker Compose lance Strapi et Next.js en **mode développement** (pas d'image de production : ni `strapi build`, ni `next build`).
- La « série de visites » et le badge « Assidu » sont des données de démonstration : aucune logique de visite quotidienne n'est implémentée.
- La validation d'une réponse par la rédaction se fait dans l'administration de Strapi (pas d'action côté membre).
- La liste des membres est lue en entier pour le classement, les mentions et l'affichage des auteurs : adapté à cette échelle, à paginer au-delà de quelques milliers de membres.
- L'authentification est celle de Users & Permissions (inscription, connexion, renouvellement de jeton) ; pas de confirmation d'e-mail ni de réinitialisation de mot de passe dans l'interface.

**Pistes d'évolution.** Playwright sur les parcours (publier, répondre, « Utile »), images Docker de production (`strapi build`, `next build`), pagination du classement, file de modération, mise en cache ciblée des lectures (`revalidateTag`) maintenant que la structure est stable.
