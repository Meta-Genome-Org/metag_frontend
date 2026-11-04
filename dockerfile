FROM node:18@sha256:c6ae79e38498325db67193d391e6ec1d224d96c693a8a4d943498556716d3783 as build

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

