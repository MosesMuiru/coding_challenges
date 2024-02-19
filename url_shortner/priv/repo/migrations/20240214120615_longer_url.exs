defmodule UrlShortner.Repo.Migrations.LongerUrl do
  use Ecto.Migration

  def change do
  create table(:longer_url) do
    add :long, :string
    timestamps()

  end
  end
end
