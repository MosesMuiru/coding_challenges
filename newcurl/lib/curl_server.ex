defmodule CurlServer do
  def run do
    connect()
    |> accept_connection()
  end

  def connect do
    {:ok, socket} = :gen_tcp.listen(80, [:binary, active: false, reuseaddr: true])
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
