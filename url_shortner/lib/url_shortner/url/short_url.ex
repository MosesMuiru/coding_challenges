defmodule UrlShortner.Url.ShortUrl do
  alias UrlShortner.Url.LongUrl
  # this is used to create schema

  import Ecto.Changeset
  use Ecto.Schema

  schema "shorter_url" do
    field :short, :string
    belongs_to :short_url, LongUrl

    timestamps()
    # field :short_url, string
  end

  def changeset(url, params \\ %{}) do
    url
    |> cast(params, [:stort_url])
    |> validate_required([:short_url])
  end
end
  