defmodule NetguruAssignment.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias NetguruAssignment.Repo

  alias NetguruAssignment.Articles.Article

  @doc """
  Returns the list of articles.
  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.
  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates an article.
  """
  def create_article(attrs \\ %{}, author) do
    author
    |> Ecto.build_assoc(:articles)
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes an Article.
  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.
  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end

  @doc """
  Returns an Article with author loadaed
  """
  def preload_author(article) do
    Repo.preload(article, :author)
  end
end
