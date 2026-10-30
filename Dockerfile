# Stage 1: Build Flutter Web
FROM ghcr.io/cirruslabs/flutter:3.29.0 AS build-env

WORKDIR /app

# Copy dependency configs first for caching
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the project files
COPY . .

# Build Flutter Web in release mode without wasm dry-run issues
RUN flutter config --no-wasm && flutter build web --release --no-wasm-dry-run

# Stage 2: Production Nginx Server
FROM nginx:alpine

# Copy custom Nginx configuration for Flutter SPA routing & caching
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build artifacts from builder stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]





