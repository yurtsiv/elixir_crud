defmodule NetguruAssignment.Auth.ErrorHandler do
  @moduledoc """
  Handles Guardian authentication error
  """
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    send_resp(conn, 401, "Unauthorized")
  end
end
