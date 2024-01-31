defmodule CurlServer do
  require Logger
  def run(port) do
    connect(port)
    |> accept_connection()
  end

  def connect(port) do
    opts = [
      :binary, active: false, reuseaddr: true
    ]
    # error handling to make sure the server port will alsways run

    # case :gen_tcp.listen(5200, opts) do
    #   {:ok, socket} -> accept_connection(socket)
    #      IO.puts("port at --> #{port}")
    #   {:error, _} -> connect()
    #   _-> IO.puts("waah kuna shida hapa")

    # end
    {:ok, socket} = :gen_tcp.listen(port, opts)
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

   fetched_data = fetching_data(data, socket_pid)
    # |> send_resp(socket_pid)

    IO.puts("am sending the reply")
    Logger.info(fetched_data)
    IO.puts("this is the logginn info")
    :gen_tcp.send(socket_pid, fetched_data)

    IO.puts("done")

  end
  # after receiving a request it should send a responce to the client him self

  defp fetching_data(url, socket_pid) do

    case HTTPoison.get(url) do
      {_, %HTTPoison.Response{status_code: status_code, body: _body}} ->
        # IO.puts("status code: #{status_code}")
        # send_resp(status_code, socket_pid)
        status_code

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found ")
        "noot found mother fucker"
        # status_code
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        reason
    end
  end
    def send_resp(fetched_data, socket_pid) do
      IO.inspect(fetched_data)
      IO.puts("above is the fetched data")
      :gen_tcp.send(socket_pid, "here the data is sent")
      # :gen_tcp.close(socket_pid)
      IO.puts("response has been sent")
    end

end
