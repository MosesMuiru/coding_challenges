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
  end
  # after receiving a request it should send a responce to the client him self
end
