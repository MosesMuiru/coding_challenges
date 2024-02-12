defmodule UrlShortner.Url.AccessDb do
  # this is for accessing the db
  alias UrlShortner.Url.UrlEncode
  alias UrlShortner.Repo

  alias UrlShortner.Url.LongUrl
  #
  def create_short_url(long_url) do
    new_url = UrlEncode.encode_url(long_url)
    # change it to a map/struct
    seed = %{
      long_url: long_url,
      short_url: new_url
    }
    LongUrl.changeset(%LongUrl{},seed)
    # |> Repo.insert()
  end

  # get all the data exists
  
end
