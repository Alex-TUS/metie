# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :metie,
  ecto_repos: [Metie.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configure the endpoint
config :metie, MetieWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: MetieWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Metie.PubSub,
  live_view: [signing_salt: "tNk+BM0U"]

# Configure Elixir's Logger
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :metie, :location, latitude: 53.178, longitude: -6.819

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
