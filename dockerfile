FROM node:25@sha256:78839ac448c23517f8eab2e8f7943d9b4f73979eb7f8bed2c73dbf72ff869e7b as build

ENV NODE_ENV=production

WORKDIR ./

COPY package.json .
COPY package-lock.json . 

RUN npm install 

COPY . .

EXPOSE 3000

RUN npm run build

#deploy 
FROM nginx:alpine@sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606 as production

COPY --from=build /build /var/www/html/
COPY ./conf/subsite.conf /etc/nginx/conf.d/default.conf

