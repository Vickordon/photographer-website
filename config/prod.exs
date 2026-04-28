import Config

config :photographer, Photographer.Repo,
  ssl: true,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    """

config :photographer, PhotographerWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base,
  server: true

config :logger, level: :info
