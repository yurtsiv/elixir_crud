defmodule NetguruAssignment.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :netguru_assignment,
    module: NetguruAssignment.Auth.Guardian,
    error_handler: NetguruAssignment.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end