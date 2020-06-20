defmodule Fish.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :content, :text
      add :author_id, references(:users)

      timestamps()
    end
  end
end
