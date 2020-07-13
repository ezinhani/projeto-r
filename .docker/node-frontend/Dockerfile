FROM node:14.4.0-alpine3.12 as builder

LABEL maintainer="Eduardo Zinhani <ezinhani@gmail.com>"

WORKDIR /app

COPY ./frontend/package*.json ./
RUN npm install

COPY ./frontend/src/ ./src/
COPY ./frontend/public/ ./public/

ARG NPM_ENV=development
RUN npm run build:${NPM_ENV}

FROM nginx:1.19.0-alpine
RUN apk update \
    && apk upgrade \
    && apk --update add logrotate \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && apk add --no-cache nano
RUN touch /var/log/messages
COPY .docker/nginx/logrotate/nginx /etc/logrotate.d/
COPY --from=builder /usr/src/app/build/ /usr/share/nginx/html
RUN touch /root/.bashrc | echo "PS1='\w\$ '" >> /root/.bashrc

EXPOSE 80