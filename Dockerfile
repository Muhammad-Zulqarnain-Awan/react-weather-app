FROM node:alpine AS build-cont
LABEL maintainer="Muhammad Zulqarnain <muhammad.zulqarnain1001@gmail.com>"

WORKDIR /home/node/app

COPY package.json package-lock.json ./

RUN npm install
COPY ./ ./
RUN npm run build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=build-cont /home/node/app/build ./