defmodule NetguruAssignmentWeb.AuthorController do
  use NetguruAssignmentWeb, :controller

  alias NetguruAssignment.Authors
  alias NetguruAssignment.Authors.Author
  alias NetguruAssignment.Auth

  action_fallback NetguruAssignmentWeb.FallbackController

  def index(conn, _params) do
    authors = Authors.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    IO.puts "hoolllla"
    with {:ok, %Author{} = author} <- Authors.create_author(author_params) do
      {:ok, token, claims} = Auth.Guardian.encode_and_sign(author)
      render(conn, "author_created.json", %{author: author, token: token})
      json(conn, %{token: token})
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

  def delete(conn, %{"id" => id}) do
    author = Authors.get_author!(id)

    with {:ok, %Author{}} <- Authors.delete_author(author) do
      send_resp(conn, :no_content, "")
    end
  end
end
