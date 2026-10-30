# Stage 1: Build Flutter Web
FROM ghcr.io/cirruslabs/flutter:3.29.0 AS build-env

ENV CI=true

WORKDIR /app

# Ensure git safe directory in docker
RUN git config --global --add safe.directory /sdks/flutter 2>/dev/null || true

# Copy dependency configs first for caching
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the project files
COPY . .

# Build Flutter Web with verbose output so exact compilation error is shown in logs
RUN flutter build web --release --no-tree-shake-icons -v

# Stage 2: Production Nginx Server
FROM nginx:alpine

# Copy custom Nginx configuration for Flutter SPA routing & caching
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build artifacts from builder stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]










