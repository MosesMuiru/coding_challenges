defmodule UrlShortner.Repo.Migrations.ShorterUrl do
  use Ecto.Migration
  
  # this is the change for the shorturl
  def change do

    create table(:shorter_url) do
      
      add :short, :string
      add :long_id, references(:longer_url)

      timestamps()
    end
  
  end
end
