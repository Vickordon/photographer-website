import Config

config :photographer, Photographer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "photographer_test",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :photographer, PhotographerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "test_secret_key_base_12345678901234567890123456789012",
  server: false

config :logger, level: :warning
config :phoenix_test, :endpoint_module, PhotographerWeb.Endpoint
