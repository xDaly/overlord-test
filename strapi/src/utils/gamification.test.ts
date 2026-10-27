import { describe, expect, it } from "vitest";

import { applyReward, mentionedHandles, readProfile, type Profile } from "./gamification";

const now = new Date("2026-10-26T10:00:00Z");

const profile = (patch: Partial<Profile> = {}): Profile => ({
  points: 0,
  monthPoints: 0,
  monthKey: "2026-10",
  badges: [],
  stats: { topics: 0, replies: 0, likes: 0, solutions: 0, votes: 0 },
  ...patch,
});

describe("applyReward", () => {
  it("ajoute les points au total et au mois en cours", () => {
    const { profile: next, effects } = applyReward(profile({ points: 10, monthPoints: 4 }), { points: { amount: 3, reason: "Réponse" } }, now);
    expect(next).toMatchObject({ points: 13, monthPoints: 7, monthKey: "2026-10" });
    expect(effects).toEqual([{ kind: "points", points: 3, reason: "Réponse", total: 13 }]);
  });

  it("repart de zéro pour le classement mensuel quand le mois a changé", () => {
    const { profile: next } = applyReward(profile({ points: 50, monthPoints: 40, monthKey: "2026-09" }), { points: { amount: 5, reason: "x" } }, now);
    expect(next).toMatchObject({ points: 55, monthPoints: 5, monthKey: "2026-10" });
  });

  it("annonce le passage au niveau supérieur", () => {
    const { effects } = applyReward(profile({ points: 22 }), { points: { amount: 5, reason: "x" } }, now);
    expect(effects).toContainEqual({ kind: "level", name: "Membre" });
  });

  it("décerne les badges de seuil à partir des compteurs, une seule fois", () => {
    const first = applyReward(profile(), { stats: { replies: 1 } }, now);
    expect(first.effects).toContainEqual({ kind: "badge", code: "premiere_reponse" });
    const second = applyReward(first.profile, { stats: { replies: 1 } }, now);
    expect(second.effects).toEqual([]);
  });

  it("attend le troisième vote pour le badge « Votre avis compte »", () => {
    expect(applyReward(profile({ stats: { topics: 0, replies: 0, likes: 0, solutions: 0, votes: 1 } }), { stats: { votes: 1 } }, now).effects).toEqual([]);
    expect(applyReward(profile({ stats: { topics: 0, replies: 0, likes: 0, solutions: 0, votes: 2 } }), { stats: { votes: 1 } }, now).effects).toContainEqual({
      kind: "badge",
      code: "citoyen",
    });
  });

  it("accepte les badges liés à l'action elle-même", () => {
    const { profile: next } = applyReward(profile(), { badges: ["bienvenue"] }, now);
    expect(next.badges).toEqual(["bienvenue"]);
  });
});

describe("readProfile", () => {
  it("tolère un compte sans gamification et ignore les badges inconnus", () => {
    expect(readProfile({ badges: ["bienvenue", "inconnu"], stats: null })).toEqual({
      points: 0,
      monthPoints: 0,
      monthKey: null,
      badges: ["bienvenue"],
      stats: { topics: 0, replies: 0, likes: 0, solutions: 0, votes: 0 },
    });
  });
});

describe("mentionedHandles", () => {
  it("extrait les @pseudos sans doublon, points compris", () => {
    expect(mentionedHandles("Merci @Vincent_ETF et @Odile.Retraite, @Vincent_ETF !")).toEqual(["Vincent_ETF", "Odile.Retraite"]);
  });
});
