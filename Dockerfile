FROM node:18
WORKDIR ./server/

COPY ./server/* ./
COPY ./client/dist/ ./dist/
EXPOSE 3000

RUN npm install

CMD ["node", "index.js"]