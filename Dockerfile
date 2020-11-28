FROM node:14-alpine AS base

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=development

COPY . .

RUN npm run build

FROM node:14-alpine AS prod

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=base /usr/src/app/dist ./dist

EXPOSE 8080

ENTRYPOINT "./entrypoint.sh"