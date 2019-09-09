defmodule NetguruAssignment.Auth.Pipeline do
  @moduledoc """
  Defines an authentication pipeline and puts current
  author to `conn` (availabe at `conn.assigns.author`) if authentication is successful
  """

  use Guardian.Plug.Pipeline,
    otp_app: :netguru_assignment,
    module: NetguruAssignment.Auth.Guardian,
    error_handler: NetguruAssignment.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug :put_author

  def put_author(conn, _attrs) do
    author = Guardian.Plug.current_resource(conn)

    conn
    |> assign(:author, author)
  end
end
