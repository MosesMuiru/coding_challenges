defmodule ShortnerWeb.HomeLive do
  use ShortnerWeb, :live_view

  alias Shortner.UrlImpl

  # mount
  def mount(_params, _session, socket) do

    socket = assign(socket, short_url: "")


    {:ok, socket}
  end

  # the assigns contain the the paramethers in the list
  # render
  # handle_event

  def handle_event("encode", %{"long_url" => long_url}, socket) do

    IO.inspect(long_url)
    IO.puts("that is the long_url hapo juu")
    # this pushed to the db and what is returrned is a long url with the name of the server

    UrlImpl.insert_url(long_url)

    # fetch for a short url from the db
 short_url = UrlImpl.get_short_url(long_url)
   |> List.first()


    socket = assign(socket, short_url: "http://localhost:4000/home/#{short_url}")
    IO.puts("this has been clicked")
    {:noreply, socket}

  end

  # this handles when the parameteer are empty
  def handle_event("encode", _params, socket) do

    IO.puts("this is empty")

    {:noreply, socket}
  end
end
