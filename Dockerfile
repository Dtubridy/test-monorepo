FROM node:12.7-alpine AS build

ARG base_path
RUN echo $base_path
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install

ENV PATH="./node_modules/.bin:$PATH"
COPY . .
RUN ng build frontend
### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
