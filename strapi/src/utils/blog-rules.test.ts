import { describe, expect, it } from "vitest";

import { parseNewBlogPost } from "./blog-rules";

const content = "Je verse chaque mois la même somme sur un ETF monde, voici mon bilan après cinq ans.";

describe("parseNewBlogPost", () => {
  it("normalise le titre et garde l'espace choisi", () => {
    expect(parseNewBlogPost({ title: "  Mon   bilan après cinq ans ", content, category: "cat1" })).toEqual({
      title: "Mon bilan après cinq ans",
      content,
      category: "cat1",
    });
  });

  it("accepte un billet sans espace", () => {
    expect(parseNewBlogPost({ title: "Mon bilan après cinq ans", content }).category).toBeNull();
  });

  it("refuse un titre trop court et un texte de moins de 60 caractères", () => {
    expect(() => parseNewBlogPost({ title: "Court", content })).toThrow(/title/);
    expect(() => parseNewBlogPost({ title: "Mon bilan après cinq ans", content: "Trop bref." })).toThrow(/content/);
  });

  it("ignore l'auteur et les compteurs envoyés", () => {
    expect(parseNewBlogPost({ title: "Mon bilan après cinq ans", content, author: 3, usefulBase: 99 })).not.toHaveProperty("author");
  });
});
