FROM node:22-bookworm-slim

WORKDIR /app

COPY package.json package-lock.json ./
COPY strapi/package.json strapi/package.json
COPY frontend/package.json frontend/package.json
RUN npm ci

COPY . .
