defmodule NewClient do
  def connect(port, message) do
    opts = [
      :binary,
      active: false,
      reuseaddr: true
    ]

    case :gen_tcp.connect(~c"localhost", port, opts) do
      {:ok, socket} -> send_to_server(socket, message)
      {:error, reason} -> IO.inspect(reason)
    end
  end

  def send_to_server(socket, message) do
    :gen_tcp.send(socket, message)
    IO.puts("this sis the message")
    IO.puts(message)
    # :gen_tcp.close(socket)
    receive_from_server(socket)
  end

  # the receiving side of the coine
  def receive_from_server(socket) do
    # {:ok, message} = :gen_tcp.recv(socket, 0)
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} -> IO.puts data
      {:error, reason} -> IO.puts reason
      _-> IO.puts("msee hii kity sioni ikiwork at all in any time soon")

    end
    
    :gen_tcp.close(socket)
  end
end
