# Stage 1: Build Flutter Web
FROM ghcr.io/cirruslabs/flutter:3.29.0 AS build-env

# Disable analytics and git safe directory warnings
ENV CI=true
ENV FLUTTER_WEB_USE_SKIA=false

WORKDIR /app

# Ensure git does not complain in docker
RUN git config --global --add safe.directory /sdks/flutter 2>/dev/null || true

# Copy dependency configs first for caching
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the project files
COPY . .

# Build Flutter Web using dart2js renderer html/canvaskit without tree shaking issues
RUN flutter build web --release --no-tree-shake-icons --no-wasm-dry-run

# Stage 2: Production Nginx Server
FROM nginx:alpine

# Copy custom Nginx configuration for Flutter SPA routing & caching
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build artifacts from builder stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]








