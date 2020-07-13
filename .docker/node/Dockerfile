FROM node:14.4.0-alpine3.12

LABEL maintainer="Eduardo Zinhani <ezinhani@gmail.com>"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache openssl \
    && apk add --no-cache bash \
    && apk add --no-cache nano

WORKDIR /app

EXPOSE 3000