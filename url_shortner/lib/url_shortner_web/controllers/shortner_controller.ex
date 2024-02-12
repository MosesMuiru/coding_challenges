defmodule UrlShortnerWeb.ShortnerController do
  alias UrlShortner.Url.AccessDb

  use UrlShortnerWeb, :controller

  # this is for returning all index

  # def index(conn, %{"url_params" => url_params} = params) do
  #   # IO.puts("this should return the data")

  # end

  # this is used to create the items in the database
  def create(conn, %{"url_params" => url_params}) do
    short_url =
      url_params
      |> AccessDb.create_short_url()

    json(conn, short_url)
  end
end
