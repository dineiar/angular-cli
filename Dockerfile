FROM node:14.18.0-alpine

LABEL authors="Alejandro Such <alejandro.such@gmail.com> , Mihai Bob <mihai.m.bob@gmail.com>"

RUN apk update \
  && apk add --update alpine-sdk python3 \
  && yarn global add @angular/cli@12.2.8 \
  && ng config --global cli.packageManager yarn \
  && apk del alpine-sdk python3 \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache clean --force \
  && yarn cache clean \
  && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd

EXPOSE 4200

# Replaces default node entrypoint, which forces "node" command by default
COPY docker-entrypoint.sh /usr/local/bin/

CMD [ "ng" ]