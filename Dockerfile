FROM node:8-alpine

LABEL Fidor Solutions

ARG EG_VERSION
ENV NODE_ENV production
ENV NODE_PATH /usr/local/share/.config/yarn/global/node_modules/

RUN npm install mkdirp --local

RUN -p mkdir /var/lib/eg

ENV EG_CONFIG_DIR /var/lib/eg
# Enable chokidar polling so hot-reload mechanism can work on docker or network volumes
ENV CHOKIDAR_USEPOLLING true

VOLUME /var/lib/eg

RUN yarn global add express-gateway@$EG_VERSION

COPY ./bin/generators/gateway/templates/basic/config /var/lib/eg
COPY ./lib/config/models /var/lib/eg/models

EXPOSE 8080 9876

CMD ["node", "-e", "require('express-gateway')().run();"]







