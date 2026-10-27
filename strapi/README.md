# Backend — Strapi v5

API REST de la communauté Le Revenu : Content Types, relations, controllers, services, policies et permissions, sur PostgreSQL.
Toute la logique métier et la persistance sont ici.

Installation, lancement, modèle de données, permissions et policies : voir le [README à la racine](../README.md).

```bash
npm run dev:strapi              # depuis la racine : http://localhost:1337
npm run seed -w strapi          # données de démonstration + jeton d'API en lecture seule
npm test -w strapi              # règles métier et policies (Vitest)
npm run test:api -w strapi      # tests d'API contre un Strapi démarré et alimenté
```

Variables d'environnement : un seul fichier `.env` à la racine du dépôt (les scripts lisent `../.env`), voir le [README à la racine](../README.md#le-fichier-env).
