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
FROM nginx:alpine@sha256:fed7e14be83cbd2661a75cdc5b872d936cf155d46c327084d30b8df19ae88d72 as production

# Apply Alpine security fixes the base image doesn't include yet. CI passes
# today's date as OS_UPDATES_DATE so this layer is rebuilt at least daily.
ARG OS_UPDATES_DATE
RUN apk upgrade --no-cache

COPY --from=build /build /var/www/html/
COPY ./conf/subsite.conf /etc/nginx/conf.d/default.conf

