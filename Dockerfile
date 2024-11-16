# Build an application
FROM node:18 AS builder
WORKDIR /app

RUN addgroup -S node || true && adduser -S node -G node || true

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Serve an application
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
