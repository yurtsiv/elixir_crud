defmodule NetguruAssignmentWeb.ArticleController do
  use NetguruAssignmentWeb, :controller

  alias NetguruAssignment.Articles
  alias NetguruAssignment.Articles.Article

  action_fallback NetguruAssignmentWeb.FallbackController

  def index(conn, _params) do
    articles = Articles.list_articles() |> Articles.preload_author()
    render(conn, "index.json", articles: articles_with_authors)
  end

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <- Articles.create_article(conn.assigns.author, article_params) do
      article_with_authour = Articles.preload_author(article)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article_with_authour)
    end
  end

  def show(conn, %{"id" => id}) do
    article = id |> Articles.get_article!() |> Articles.preload_author()
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Articles.get_article!(id)

    with {:ok, %Article{} = article} <- Articles.update_article(article, article_params) do
      article_with_authour = Articles.preload_author(article)
      render(conn, "show.json", article: article_with_author)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Articles.get_article!(id)

    with {:ok, %Article{}} <- Articles.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
