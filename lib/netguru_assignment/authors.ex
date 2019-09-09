defmodule NetguruAssignment.Authors do
  @moduledoc """
  The Authors context.
  """

  import Ecto.Query, warn: false
  alias NetguruAssignment.Repo

  alias NetguruAssignment.Authors.Author
  alias NetguruAssignment.Auth

  @doc """
  Gets a single author.
  """
  def get_author!(id), do: Repo.get!(Author, id)

  def get_author(id), do: Repo.get(Author, id)

  @doc """
  Creates an author.
  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an author.
  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.
  """
  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  @doc """
  Returns an authentiaction token for a given Author
  """
  def get_auth_token(author) do
    Auth.Guardian.encode_and_sign(author)
  end
end
