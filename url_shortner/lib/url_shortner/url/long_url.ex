defmodule UrlShortner.Url.LongUrl do
  # this is for long url
  alias UrlShortner.Url.ShortUrl
  import Ecto.Changeset
  use Ecto.Schema

  schema "longer_url" do
    field :long_url, :string
    has_one :short_url, ShortUrl

    timestamps()
  end

  # validations
  #  params
  def changeset(url, params \\ %{}) do
    url
    |> cast(params, [:long_url])
    |> validate_required([:long_url])
  end
end
