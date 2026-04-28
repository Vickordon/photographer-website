# Build stage
FROM elixir:1.14.5-otp-25 AS build

# Install build dependencies (Debian-based)
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy dependency files
COPY mix.exs ./

# Get dependencies (will generate mix.lock automatically)
RUN mix deps.get --only prod

# Copy configuration
COPY config config

# Copy source code
COPY lib lib

# Copy static files (if they exist)
COPY priv priv

# Build the release
RUN mix release

# Runtime stage
FROM debian:bullseye-slim AS app

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libstdc++6 \
    openssl \
    ca-certificates \
    imagemagick \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/dev/rel/photographer .

# Set environment variables
ENV LANG=C.UTF-8
ENV MIX_ENV=prod

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:4000/health || exit 1

# Start the application
ENTRYPOINT ["/app/bin/server"]
CMD ["start"]
