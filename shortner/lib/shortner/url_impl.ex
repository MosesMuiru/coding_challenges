defmodule Shortner.UrlImpl do
  # here is all the access to the db
  alias Shortner.Repo
  alias Shortner.UrlEncode
  alias Shortner.Urls
  import Ecto.Query

  # this will get all the urls in the db booth short and longj
  def get_all do
    Repo.all(Urls)
  end

  # this will return a short url
  defp encode_url(long_url) do
    UrlEncode.encode_url(long_url)
  end

  # inserting urls in the database

  def insert_url(long_url) do
    # hash the long_url
    short_url = encode_url(long_url)
    url = %{long_url: long_url, short_url: short_url}

    Urls.changeset(%Urls{}, url)
    |> Repo.insert()
  end

  # return a specific long url based on a short_url
  @spec get_long_url(any()) :: any()
  def get_long_url(short_url) do
    query = from u in "urls", where: u.short_url == ^short_url, select: u.long_url
    # Repo.get_by(Urls, short_url: short_url)
    Repo.all(query)
  end

  def get_short_url(long_url) do
    query = from u in "urls", where: u.long_url == ^long_url, select: u.short_url

    Repo.all(query)
  end
end
