# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :monkey, ecto_repos: [Monkey.Repo]

# Configures the endpoint
config :monkey, MonkeyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mKQY+IplKkh1IoeCOGyp3jFEM9ODtgKCBT7Pc7V/juuGMKeCYwIGrgTJxgWLwSnl",
  render_errors: [view: MonkeyWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Monkey.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian
config :monkey, MonkeyWeb.Guardian,
  issuer: "Monkey",
  secret_key: "MDLMflIpKod5YCnkdiY7C4E3ki2rgcAAMwfBl0+vyC5uqJNgoibfQmAh7J3uZWVK",
  # optional
  allowed_algos: ["HS256"],
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
