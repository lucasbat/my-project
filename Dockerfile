FROM node:18-alpine AS builder

RUN apk update && \
    apk add --no-cache git

WORKDIR /app

RUN addgroup -S node || true && adduser -S node -G node || true

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
