defmodule ShortnerWeb.PageController do
  use ShortnerWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # IO.inspect(conn)
    IO.puts("msseee hiii inwork")
    redirect(conn, to: "/we")
  end
end
