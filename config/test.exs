use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :netguru_assignment, NetguruAssignmentWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :netguru_assignment, NetguruAssignment.Repo,
  username: "postgres",
  password: "postgres",
  database: "netguru_assignment_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
