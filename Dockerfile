FROM node:20-alpine AS build
WORKDIR /app

RUN apk add --no-cache git

ADD https://github.com/darkost12/steam-idler-plus/archive/refs/heads/main.tar.gz /tmp/src.tar.gz
RUN tar -xzf /tmp/src.tar.gz --strip-components=1 -C /app \
    && rm /tmp/src.tar.gz

RUN set -ex ;\
    npm install --omit=dev ;\
    npm cache clean --force

FROM node:20-alpine
WORKDIR /steam-idler-plus-main
COPY --from=build /app ./

ENV HOME=/steam-idler-main/shared

CMD ["node", "idler.js"]
