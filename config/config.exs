# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.

import Config

# Import mailer config
import_config "mailer.exs"

config :photographer,
  ecto_repos: [Photographer.Repo],
  generators: [timestamp_type: :utc_datetime]

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
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: PhotographerWeb.ErrorHTML, json: PhotographerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Photographer.PubSub,
  live_view: [signing_salt: "photographer_salt"]

config :esbuild,
  version: "0.17.11",
  photographer: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :logger, :console, format: "$time $metadata[$level] $message\n", metadata: [:request_id]
config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
