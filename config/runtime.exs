import Config

config :photographer, PhotographerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: PhotographerWeb.ErrorHTML, json: PhotographerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Photographer.PubSub,
  live_view: [signing_salt: "photographer_live_salt"]

config :photographer, Photographer.Mailer, adapter: Swoosh.Adapters.Local

config :esbuild,
  version: "0.17.11",
  photographer: [
    args: ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
