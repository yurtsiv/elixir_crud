defmodule NetguruAssignmentWeb.AuthorController do
  @moduledoc """
  Handles Author create/read/update
  """
  use NetguruAssignmentWeb, :controller

  alias NetguruAssignment.Authors
  alias NetguruAssignment.Authors.Author

  action_fallback NetguruAssignmentWeb.FallbackController
  plug :authorize_author when action in [:update]

  def create(conn, %{"author" => author_params}) do
    with {:ok, %Author{} = author} <- Authors.create_author(author_params) do
      {:ok, token, _claims} = Authors.get_auth_token(author)
      render(conn, "author_created.json", %{author: author, token: token})
    end
  end

  def show(conn, %{"id" => id}) do
    author = Authors.get_author!(id)
    render(conn, "show.json", author: author)
  end

  def update(conn, %{"id" => id, "author" => author_params}) do
    author = Authors.get_author!(id)

    with {:ok, %Author{} = author} <- Authors.update_author(author, author_params) do
      render(conn, "show.json", author: author)
    end
  end

  defp authorize_author(conn, _) do
    {given_id, _} = Integer.parse(conn.params["id"])

    if given_id == conn.assigns.author.id do
      conn
    else
      conn
      |> send_resp(:unauthorized, "Unauthorized")
      |> halt()
    end
  end
end
