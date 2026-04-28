# Build stage
FROM hexpm/elixir:1.15.7-erlang-26.1.2-alpine-3.18.4 AS build

# Install build dependencies
RUN apk add --no-cache build-base git nodejs npm

WORKDIR /app

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Copy mix files
COPY mix.exs mix.lock ./

# Get dependencies
RUN mix deps.get --only prod

# Copy application files
COPY config config
COPY lib lib
COPY priv priv
COPY assets assets

# Install and build assets
RUN cd assets && npm install && npm run deploy

# Compile release
RUN mix release

# Runtime stage
FROM alpine:3.18.4 AS app

# Install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ca_certificates imagemagick

WORKDIR /app

# Copy release from build stage
COPY --from=build /app/_build/prod/rel/photographer ./

# Create uploads directory
RUN mkdir -p priv/static/uploads && \
    chown -R appuser:appgroup priv/static/uploads

# Create non-root user
RUN addgroup -g 1000 -S appgroup && \
    adduser -u 1000 -S appuser -G appgroup

USER appuser

# Expose port
EXPOSE 4000

# Set environment variables
ENV MIX_ENV=prod

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s \
    CMD wget --no-verbose --tries=1 --spider http://localhost:4000/health || exit 1

# Start the application
ENTRYPOINT ["/app/bin/server"]
CMD ["start"]
