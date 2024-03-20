defmodule LubiMandou.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :body, :string

      timestamps(type: :utc_datetime)
    end
  end
end
