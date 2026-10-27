import { describe, expect, it } from "vitest"

import { hrefWith, outOfRangeHref, resolveOrder, resolvePage } from "./feed-paging"

describe("resolvePage", () => {
  it("lit un entier positif et retombe sur la première page sinon", () => {
    expect(resolvePage("3")).toBe(3)
    for (const bad of [undefined, "", "0", "-2", "1.5", "abc"]) expect(resolvePage(bad)).toBe(1)
  })
})

describe("resolveOrder", () => {
  it("ne connaît que les deux ordres de date", () => {
    expect(resolveOrder("anciennes")).toBe("oldest")
    expect(resolveOrder("recentes")).toBe("newest")
    expect(resolveOrder("n-importe-quoi")).toBeUndefined()
    expect(resolveOrder(undefined)).toBeUndefined()
  })
})

describe("outOfRangeHref", () => {
  it("ramène à la dernière page quand on dépasse la fin", () => {
    expect(outOfRangeHref("/", { tri: "recentes" }, { page: 99, pageCount: 3 })).toBe("/?tri=recentes&page=3")
  })

  it("ramène à l'adresse sans page quand il n'y en a qu'une", () => {
    expect(outOfRangeHref("/espaces/bourse", { page: "2" }, { page: 2, pageCount: 1 })).toBe("/espaces/bourse")
  })

  it("ne fait rien dans les pages valides, ni quand la liste est vide", () => {
    expect(outOfRangeHref("/", {}, { page: 3, pageCount: 3 })).toBeNull()
    expect(outOfRangeHref("/", {}, { page: 1, pageCount: 1 })).toBeNull()
    expect(outOfRangeHref("/", {}, { page: 4, pageCount: 0 })).toBeNull()
  })
})

describe("hrefWith", () => {
  it("garde les autres paramètres et change celui demandé", () => {
    expect(hrefWith("/", { tri: "recentes", ordre: "anciennes" }, { page: "2" })).toBe("/?tri=recentes&ordre=anciennes&page=2")
  })

  it("retire un paramètre vidé et renvoie le chemin seul quand il ne reste rien", () => {
    expect(hrefWith("/espaces/bourse", { page: "2" }, { page: undefined })).toBe("/espaces/bourse")
    expect(hrefWith("/", { tri: "recentes", page: "4" }, { ordre: "anciennes", page: undefined })).toBe("/?tri=recentes&ordre=anciennes")
  })
})
