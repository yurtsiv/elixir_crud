defmodule NetguruAssignmentWeb.AuthorView do
  use NetguruAssignmentWeb, :view
  alias NetguruAssignmentWeb.AuthorView

  def render("index.json", %{authors: authors}) do
    %{data: render_many(authors, AuthorView, "author.json")}
  end

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author.json", %{author: author}) do
    %{id: author.id,
      first_name: author.first_name,
      last_name: author.last_name,
      age: author.age}
  end
end
