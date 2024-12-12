FROM node:22-alpine

WORKDIR /app

COPY api/package*.json ./

RUN npm install

COPY api .

RUN npm run build

CMD ["node", "dist/main.js"]