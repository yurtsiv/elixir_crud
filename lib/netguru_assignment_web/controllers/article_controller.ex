defmodule NetguruAssignmentWeb.ArticleController do
  use NetguruAssignmentWeb, :controller

  alias NetguruAssignment.Articles
  alias NetguruAssignment.Articles.Article

  action_fallback NetguruAssignmentWeb.FallbackController
  plug :authorize_author when action in [:delete]

  def index(conn, _params) do
    articles = Articles.list_articles() |> Articles.preload_author()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <-
           Articles.create_article(article_params, conn.assigns.author) do
      article_with_authour = Articles.preload_author(article)

      conn
      |> put_status(:created)
      |> render("show.json", article: article_with_authour)
    end
  end

  def delete(conn, %{"id" => id}) do
    with article <- Articles.get_article!(id),
         {:ok, %Article{}} <- Articles.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end

  defp authorize_author(conn, _) do
    article = Articles.get_article!(conn.params["id"])

    if article.author_id == conn.assigns.author.id do
      conn
    else
      conn
      |> send_resp(:unauthorized, "Unathorized")
      |> halt()
    end
  end
end
