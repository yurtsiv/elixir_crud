defmodule NetguruAssignmentWeb.AuthorController do
  use NetguruAssignmentWeb, :controller

  alias NetguruAssignment.Authors
  alias NetguruAssignment.Authors.Author

  action_fallback NetguruAssignmentWeb.FallbackController

  def index(conn, _params) do
    authors = Authors.list_authors()
    render(conn, "index.json", authors: authors)
  end

  def create(conn, %{"author" => author_params}) do
    IO.puts "hoolllla"
    with {:ok, %Author{} = author} <- Authors.create_author(author_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.author_path(conn, :show, author))
      |> render("show.json", author: author)
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
