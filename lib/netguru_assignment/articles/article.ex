defmodule NetguruAssignment.Articles.Article do
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

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :description, :body, :author])
    |> put_change(:published_date, NaiveDateTime.utc_now |> NaiveDateTime.truncate(:second))
    |> validate_required([:title, :description, :body, :author, :published_date])
    |> validate_length(:title, max: 150)
  end
end
