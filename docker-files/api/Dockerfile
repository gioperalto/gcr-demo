FROM node:22-alpine

COPY --from=datadog/serverless-init:1 /datadog-init /app/datadog-init

WORKDIR /app

COPY api/package*.json ./

RUN npm install

RUN npm install --prefix /dd_tracer/node dd-trace  --save

COPY api .

RUN npm run build

ENTRYPOINT ["/app/datadog-init"]

CMD ["node", "dist/main.js"]