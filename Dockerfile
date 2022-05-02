FROM node:18-alpine3.15

LABEL org.label-schema.author='DataStema'
LABEL org.label-schema.name='datastemalux/couchgres'
LABEL org.label-schema.description='CouchDB sync with PostgreSQL'

ENV NODE_ENV=production

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app

COPY package*.json ./

RUN npm install
# If you are building your code for production
RUN npm ci --only=production

COPY --chown=node:node . .

EXPOSE 8888
USER node

CMD [ "node", "/home/node/app/bin/daemon.js" ]


