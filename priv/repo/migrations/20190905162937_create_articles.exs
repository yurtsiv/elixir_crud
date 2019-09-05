defmodule NetguruAssignment.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :description, :string
      add :body, :string
      add :published_date, :naive_datetime

      timestamps()
    end

  end
end
