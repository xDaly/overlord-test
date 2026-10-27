import { defineConfig } from "vitest/config";

/** Tests d'API : ils ciblent un Strapi démarré, d'où l'exécution en série et les délais plus larges. */
export default defineConfig({
  test: {
    environment: "node",
    include: ["tests/api/**/*.api.test.ts"],
    fileParallelism: false,
    testTimeout: 20_000,
    hookTimeout: 30_000,
  },
});
