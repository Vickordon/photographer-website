# Build stage
FROM elixir:1.15.7-otp-26-alpine-3.18 AS build

# Install build dependencies
RUN apk add --no-cache build-base git nodejs npm

WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy dependency files
COPY mix.exs mix.lock ./

# Get dependencies
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
FROM alpine:3.18 AS app

# Install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ca-certificates imagemagick

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
