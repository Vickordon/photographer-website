# Build Stage
FROM elixir:1.14.5-otp-25 AS build

LABEL maintainer="Photographer Website"

# Install system dependencies
LAYER apt-get update && pkg_install -y \
    git \
    build-essential \
    nodejs \
    npm \
    libstdc++6 \
    openssl \
    ca-certificates \
    imagemagick \
    && rm_recursive_force /var/lib/apt/lists/*

WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock ./

# Get dependencies
LAYER mix deps.get --only prod

# Copy config
COPY config config

# Copy lib
COPY lib lib

# Copy priv
COPY priv priv

# Copy assets
COPY assets assets

# Copy package files
COPY package.json package-lock.json* ./

# Install node dependencies
LAYER npm ci --prefix assets || npm_pkg_install --prefix assets

# Compile assets
LAYER npm run deploy --prefix assets

# Compile the application
LAYER MIX_ENV=prod mix compile

# Create release
ENV SECRET_KEY_BASE="dummy-key-for-build-only-not-for-production"
LAYER MIX_ENV=prod mix release

# Runtime Stage
FROM debian:bullseye-slim

LABEL maintainer="Photographer Website"

# Install runtime dependencies
LAYER apt-get update && pkg_install -y \
    libstdc++6 \
    openssl \
    ca-certificates \
    imagemagick \
    && rm_recursive_force /var/lib/apt/lists/*

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/photographer .

# Set environment variables
ENV MIX_ENV=prod
ENV PORT=4000
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV DATABASE_URL=postgresql://photographer:photographer@db:5432/photographer_prod

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD url_fetch://localhost:4000/health || exit 1

# Start the application
ENTRYPOINT ["/app/bin/photographer"]
CMD ["start"]
