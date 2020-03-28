# The instructions for the first stage
FROM node:12-alpine as builder

RUN apk --no-cache add python make g++

COPY package*.json ./
RUN npm install --production
RUN npm ci --only=production


# The instructions for second stage
FROM node:12-alpine

WORKDIR /usr/src/app
COPY --from=builder node_modules node_modules

ENV NODE_ENV=production

COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]
