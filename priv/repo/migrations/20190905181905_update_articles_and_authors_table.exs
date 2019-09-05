defmodule NetguruAssignment.Repo.Migrations.UpdateArticlesAndAuthorsTable do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :author_id, references(:authors)
    end
  end
end
