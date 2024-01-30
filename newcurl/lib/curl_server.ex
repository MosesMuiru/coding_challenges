defmodule CurlServer do
  def run do
    connect()
    |> accept_connection()
  end

  def connect do
    opts = [
      :binary, active: false, reuseaddr: true
    ]
    # error handling to make sure the server port will alsways run
    port = 5200 + 1
    # case :gen_tcp.listen(5200, opts) do
    #   {:ok, socket} -> accept_connection(socket)
    #      IO.puts("port at --> #{port}")
    #   {:error, _} -> connect()
    #   _-> IO.puts("waah kuna shida hapa")

    # end
    {:ok, socket} = :gen_tcp.listen(5400, opts)
    IO.inspect socket
    socket

  end

  def accept_connection(socket) do
    {:ok, socket_pid} = :gen_tcp.accept(socket)
    receiving(socket_pid)
    accept_connection(socket)
  end

  def receiving(socket_pid) do
    {:ok, data} = :gen_tcp.recv(socket_pid, 0)

    IO.puts("the data")
    IO.puts(data)

    fetching_data(data)
    |> send_resp(socket_pid)


  end
  # after receiving a request it should send a responce to the client him self

  defp fetching_data(url) do

    case HTTPoison.get(url) do
      {_, %HTTPoison.Response{status_code: status_code, body: _body}} ->
        IO.puts("status code: #{status_code}")

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
    defp send_resp(fetched_data, socket_pid) do
      IO.puts(fetched_data)
      :gen_tcp.send(socket_pid, fetched_data)
      :gen_tcp.close(socket_pid)
      IO.puts("response has been sent")
    end

end
