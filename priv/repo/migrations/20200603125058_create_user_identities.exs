defmodule Fish.Repo.Migrations.CreateUserIdentities do
  use Ecto.Migration

  def change do
    create table(:user_identities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :provider, :string, null: false
      add :uid, :string, null: false
      add :user_id, references("users", on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:user_identities, [:uid, :provider])
  end
end
