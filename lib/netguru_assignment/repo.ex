defmodule NetguruAssignment.Repo do
  use Ecto.Repo,
    otp_app: :netguru_assignment,
    adapter: Ecto.Adapters.Postgres
end
