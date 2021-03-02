FROM node:12-alpine

ENV NODE_ENV production
WORKDIR /quickchart

RUN apk add --no-cache --virtual .build-deps git yarn build-base g++ python
RUN apk add --no-cache --virtual .npm-deps cairo-dev pango-dev libjpeg-turbo-dev
RUN apk add --no-cache --virtual .fonts libmount ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family font-noto fontconfig

COPY package*.json .
COPY yarn.lock .
RUN yarn install --production

RUN apk del .build-deps

COPY *.js ./
COPY lib/*.js lib/
COPY templates templates/
COPY environment environment/
COPY LICENSE .
ENV PORT=80
EXPOSE 80

ENTRYPOINT [ "yarn", "start" ]
