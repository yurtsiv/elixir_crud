# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :netguru_assignment, NetguruAssignment.Auth.Guardian,
  issuer: "netguru_assignment",
  secret_key: "KTAO3hvYqWdas3iKmD740Na3KfsDnnheeJbjUBEuI1zJibr0QgwPypc+TK/PtnJX"

config :netguru_assignment,
  ecto_repos: [NetguruAssignment.Repo]

# Configures the endpoint
config :netguru_assignment, NetguruAssignmentWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "G1nrfdqHQpz/R5yEeDZYJuCge1i4hpHCCjenT64za6vccDt/WIWTjLtgG3jdk78v",
  render_errors: [view: NetguruAssignmentWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: NetguruAssignment.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
