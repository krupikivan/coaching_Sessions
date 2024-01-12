FROM node:14 as build

WORKDIR /client

COPY package.json .
COPY package-lock.json .
RUN npm install

COPY . .
EXPOSE 8080

CMD ["npm", "start"]