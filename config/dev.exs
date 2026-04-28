import Config

config :photographer, Photographer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "photographer_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :photographer, PhotographerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  debug_errors: true,
  check_origin: false,
  code_reloader: true,
  secret_key_base: "dev_secret_key_base_12345678901234567890123456789012",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:photographer, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:photographer, ~w(--watch)]}
  ]

config :photographer, PhotographerWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"lib/photographer_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
