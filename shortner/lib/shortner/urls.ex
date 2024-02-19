defmodule Shortner.Urls do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :long_url, :string
    field :short_url, :string

    timestamps()
  end

  def changeset(urls, params \\ %{}) do
    urls
    |> cast(params, [:long_url, :short_url])
    |> validate_required([:long_url, :short_url])
    |> unique_constraint(:short_url)

    # |> verif
  end
end
