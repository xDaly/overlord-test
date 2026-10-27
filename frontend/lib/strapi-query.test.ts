import { describe, expect, it } from "vitest"

import { toQuery } from "./strapi-query"

const decoded = (params: Parameters<typeof toQuery>[0]) => decodeURIComponent(toQuery(params))

describe("toQuery", () => {
  it("writes flat values", () => {
    expect(toQuery({ "pagination[page]": 2, locale: "fr" })).toBe("pagination[page]=2&locale=fr")
  })

  it("nests objects with brackets", () => {
    expect(decoded({ filters: { category: { slug: { $eq: "bourse" } } } })).toBe("filters[category][slug][$eq]=bourse")
  })

  it("indexes arrays", () => {
    expect(decoded({ sort: ["pinned:desc", "createdAt:desc"], fields: ["title"] })).toBe(
      "sort[0]=pinned:desc&sort[1]=createdAt:desc&fields[0]=title"
    )
  })

  it("combines nested objects and arrays, as Strapi expects for populate", () => {
    expect(decoded({ populate: { replies: { fields: ["createdAt"], populate: { author: { fields: ["username"] } } } } })).toBe(
      "populate[replies][fields][0]=createdAt&populate[replies][populate][author][fields][0]=username"
    )
  })

  it("keeps booleans and numbers", () => {
    expect(decoded({ filters: { replies: { id: { $null: true } } }, pagination: { pageSize: 1, withCount: true } })).toBe(
      "filters[replies][id][$null]=true&pagination[pageSize]=1&pagination[withCount]=true"
    )
  })

  it("skips undefined and null values", () => {
    expect(toQuery({ a: undefined, b: null, c: "x", d: { e: undefined } })).toBe("c=x")
  })

  it("encodes values safely", () => {
    expect(toQuery({ "filters[title][$containsi]": "a&b=c d" })).toContain("a%26b%3Dc%20d")
  })

  it("returns an empty string without params", () => {
    expect(toQuery({})).toBe("")
  })
})
