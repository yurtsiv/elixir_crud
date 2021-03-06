defmodule NetguruAssignment.Articles.Article do
  @moduledoc """
  Defines schema and changeset for Article
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :string
    field :description, :string
    field :published_date, :naive_datetime
    field :title, :string
    belongs_to :author, NetguruAssignment.Authors.Author

    timestamps()
  end

  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body])
    |> put_change(:published_date, NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second))
    |> assoc_constraint(:author)
    |> validate_required([:title, :body, :published_date])
    |> validate_length(:title, max: 150)
  end
end
