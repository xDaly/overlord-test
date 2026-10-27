import { describe, expect, it } from "vitest";

import { AVATAR_MAX_BYTES, assertAvatarFile, parseProfileUpdate, toOwnProfile } from "./profile-rules";

const nameOf = (action: () => unknown) => {
  try {
    action();
  } catch (error) {
    return (error as Error).name;
  }
  return undefined;
};

describe("parseProfileUpdate", () => {
  it("keeps the three editable fields, trimmed", () => {
    expect(
      parseProfileUpdate({ displayName: "  Épargnant du Nord ", bio: " Je prépare un achat. ", interests: ["bourse", "retraite"] })
    ).toEqual({ displayName: "Épargnant du Nord", bio: "Je prépare un achat.", interests: ["bourse", "retraite"] });
  });

  it("ignores every field the member must not change", () => {
    const result = parseProfileUpdate({
      displayName: "Alex",
      username: "autre",
      email: "x@y.fr",
      role: 3,
      blocked: false,
      confirmed: true,
      password: "x",
      avatar: 12,
    });
    expect(result).toEqual({ displayName: "Alex" });
  });

  it("allows updating a single field", () => {
    expect(parseProfileUpdate({ bio: "Bonjour" })).toEqual({ bio: "Bonjour" });
  });

  it("allows an empty bio to clear it", () => {
    expect(parseProfileUpdate({ bio: "   " })).toEqual({ bio: "" });
  });

  it.each(["ab", "a".repeat(25), "   ", 12, null])("refuses the display name %j", (displayName) => {
    expect(nameOf(() => parseProfileUpdate({ displayName }))).toBe("ValidationError");
  });

  it("refuses a bio over 280 characters", () => {
    expect(nameOf(() => parseProfileUpdate({ bio: "a".repeat(281) }))).toBe("ValidationError");
  });

  it("refuses malformed interests", () => {
    expect(nameOf(() => parseProfileUpdate({ interests: "bourse" }))).toBe("ValidationError");
    expect(nameOf(() => parseProfileUpdate({ interests: ["Bourse Actions"] }))).toBe("ValidationError");
    expect(nameOf(() => parseProfileUpdate({ interests: [1] }))).toBe("ValidationError");
    expect(nameOf(() => parseProfileUpdate({ interests: Array.from({ length: 13 }, (_, i) => `espace-${i}`) }))).toBe("ValidationError");
  });

  it("removes duplicate interests", () => {
    expect(parseProfileUpdate({ interests: ["bourse", "bourse", "retraite"] })).toEqual({ interests: ["bourse", "retraite"] });
  });

  it("refuses a request with nothing to update", () => {
    expect(nameOf(() => parseProfileUpdate({}))).toBe("ValidationError");
    expect(nameOf(() => parseProfileUpdate({ role: 3 }))).toBe("ValidationError");
    expect(nameOf(() => parseProfileUpdate(undefined))).toBe("ValidationError");
  });
});

describe("assertAvatarFile", () => {
  const png = { mimetype: "image/png", size: 1024 };

  it.each(["image/jpeg", "image/png", "image/webp", "image/gif"])("accepts %s", (mimetype) => {
    expect(() => assertAvatarFile({ ...png, mimetype })).not.toThrow();
  });

  it.each(["image/svg+xml", "text/html", "application/pdf", "application/octet-stream"])("refuses %s", (mimetype) => {
    expect(nameOf(() => assertAvatarFile({ ...png, mimetype }))).toBe("ValidationError");
  });

  it("refuses a file over the size limit", () => {
    expect(() => assertAvatarFile({ ...png, size: AVATAR_MAX_BYTES })).not.toThrow();
    expect(nameOf(() => assertAvatarFile({ ...png, size: AVATAR_MAX_BYTES + 1 }))).toBe("ValidationError");
  });

  it("refuses a missing file", () => {
    expect(nameOf(() => assertAvatarFile(undefined))).toBe("ValidationError");
  });
});

describe("toOwnProfile", () => {
  it("exposes the member's own data and nothing technical", () => {
    const profile = toOwnProfile({
      id: 5,
      documentId: "doc",
      username: "alex",
      email: "alex@exemple.fr",
      displayName: "Alex",
      bio: "Bonjour",
      interests: ["bourse"],
      avatar: { id: 9, url: "/uploads/a.png", hash: "h", provider: "local" },
      password: "hash",
      resetPasswordToken: "t",
      blocked: false,
    });
    expect(profile).toEqual({
      id: 5,
      documentId: "doc",
      username: "alex",
      email: "alex@exemple.fr",
      displayName: "Alex",
      bio: "Bonjour",
      interests: ["bourse"],
      avatar: { id: 9, url: "/uploads/a.png" },
    });
  });

  it("defaults missing optional values", () => {
    expect(toOwnProfile({ id: 1, username: "a", email: "a@b.fr" })).toMatchObject({ bio: null, interests: [], avatar: null });
  });
});
