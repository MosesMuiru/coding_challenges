defmodule Shortner.Repo.Migrations.CreateUrl do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :long_url, :string
      add :short_url, :string

      timestamps()
    end

    create unique_index(:urls, [:short_url], on_delete: :delete_all)
  end
end
