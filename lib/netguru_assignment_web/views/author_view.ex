defmodule NetguruAssignmentWeb.AuthorView do
  use NetguruAssignmentWeb, :view
  alias NetguruAssignmentWeb.AuthorView

  def render("show.json", %{author: author}) do
    %{data: render_one(author, AuthorView, "author.json")}
  end

  def render("author_created.json", %{author: author, token: token}) do
    %{
      data: %{
        author: render_one(author, AuthorView, "author.json"),
        token: token
      }
    }
  end

  def render("author.json", %{author: author}) do
    %{id: author.id, first_name: author.first_name, last_name: author.last_name, age: author.age}
  end
end
