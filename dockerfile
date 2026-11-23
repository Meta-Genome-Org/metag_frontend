FROM node:24@sha256:8fa96264f302f58bbb13aa7339c541547b56975766ce956c875da149452a3e40 as build

ENV NODE_ENV=production

WORKDIR ./

COPY package.json .
COPY package-lock.json . 

RUN npm install 

COPY . .

EXPOSE 3000

RUN npm run build

#deploy 
FROM nginx:alpine@sha256:fb4658584bd9a916ffb6f6e365f97c25cfdb2923801f551ea08356e695f14ff7 as production

# Apply Alpine security fixes the base image doesn't include yet. CI passes
# today's date as OS_UPDATES_DATE so this layer is rebuilt at least daily.
ARG OS_UPDATES_DATE
RUN apk upgrade --no-cache

COPY --from=build /build /var/www/html/
COPY ./conf/subsite.conf /etc/nginx/conf.d/default.conf

