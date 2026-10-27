# Frontend — Next.js

Interface de la communauté Le Revenu : Next.js (App Router), React, TypeScript, Tailwind CSS.
Elle ne contient aucune logique métier ni accès à la base : tout passe par l'API de Strapi.

Installation, lancement, comptes de démonstration et choix d'architecture : voir le [README à la racine](../README.md).

```bash
npm run dev:frontend      # depuis la racine : http://localhost:3000
npm test -w frontend      # tests unitaires
npm run typecheck -w frontend
npm run lint -w frontend
```

Variables d'environnement : un seul fichier `.env` à la racine du dépôt, lu par Strapi et par Next.js (voir le [README à la racine](../README.md#le-fichier-env)). Le jeton d'API est créé par `npm run seed -w strapi`.
