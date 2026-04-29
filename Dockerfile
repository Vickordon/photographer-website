# Build Stage
FROM elixir:1.14.5-otp-25 AS build

LABEL maintainer="Photographer Website"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    nodejs \
    npm \
    libstdc++6 \
    openssl \
    ca-certificates \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Set build environment
ENV MIX_ENV=prod

# Install hex and rebar
RUN mix local.hex --force && mix local.rebar --force

# Copy mix files
COPY mix.exs mix.lock ./

# Get dependencies
RUN mix deps.get --only prod

# Copy config
COPY config config

# Copy lib
COPY lib lib

# Copy priv
COPY priv priv

# Copy assets
COPY assets assets

# Compile the application
RUN mix compile

# Copy CSS to static assets (vanilla CSS, not using Tailwind)
RUN mkdir -p priv/static/assets && cp assets/css/app.css priv/static/assets/app.css

# Compile assets (JS via esbuild + phx.digest)
RUN mix assets.deploy

# Create release
ENV SECRET_KEY_BASE="dummy-key-for-build-only-not-for-production"
RUN mix release

# Runtime Stage
FROM debian:bullseye-slim

LABEL maintainer="Photographer Website"

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    openssl \
    ca-certificates \
    imagemagick \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/photographer .

# Set environment variables
ENV MIX_ENV=prod
ENV PORT=4000

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=5 \
    CMD curl -f http://localhost:4000/ || exit 1

# Start the application
ENTRYPOINT ["/app/bin/photographer"]
CMD ["start"]
