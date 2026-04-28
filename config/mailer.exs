import Config

config :photographer, Photographer.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: System.get_env("SMTP_HOST") || "smtp.gmail.com",
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :always,
  auth: :always,
  port: String.to_integer(System.get_env("SMTP_PORT") || "587")

if config_env() in [:dev, :test] do
  config :photographer, Photographer.Mailer,
    adapter: Swoosh.Adapters.Local
end
