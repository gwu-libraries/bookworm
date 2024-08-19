FROM node

WORKDIR /app

COPY package.json .

COPY vite.config.ts .

RUN npm install

RUN npm i -g serve

COPY . .

RUN npm run build

EXPOSE 8080

CMD [ "serve", "-s", "dist"]