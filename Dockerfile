#Build a Multi-stage Docker file for containerized a Weather-App created in React.

#Import node:alpine image from docker registry
FROM node:alpine AS build-cont
LABEL maintainer="Muhammad Zulqarnain <muhammad.zulqarnain1001@gmail.com>"

#Set a working directory as default path in image
WORKDIR /home/node/app

#Copy the two json files into working directory
COPY package.json package-lock.json ./

#For installing dependencies and build the application
RUN npm install
COPY ./ ./
RUN npm run build

#Import nginx:alpine image from docker registry
FROM nginx:alpine

#Set the working directory as default path in image
WORKDIR /usr/share/nginx/html

#Copy the build data from build-cont to working directory
COPY --from=build-cont /home/node/app/build ./