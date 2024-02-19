defmodule ShortnerWeb.HomeController do
  use ShortnerWeb, :controller

  alias Shortner.UrlImpl

  def show(conn, %{"short_url" => short_url}) do
    IO.inspect(short_url)
    IO.puts("this is the short url what you said")

    long_url = UrlImpl.get_long_url(short_url)
    |> List.first()

    IO.inspect(long_url)
    IO.puts("the long url")
    redirect(conn, external: long_url)
  end
end
