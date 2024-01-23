defmodule Client do
  #  should send the message to the obvios port
  #  so when teh server is started it is automatically stated and the connection is created 
  def connect(port, message) do
    #  if i was creating a web server i will assume the meesage will be the url
    opts = [:binary, active: false, reuseaddr: true]

    case :gen_tcp.connect(~c"localhost", port, opts) do
      {:ok, socket} ->
        IO.puts("connected to server at port")
        send_data(socket, message)

      {:error, reason} ->
        IO.inspect(reason)
    end
  end

  #  url ---> then fetch the data 
  #  return the current status of the data

  def send_data(socket, message) do
    :gen_tcp.send(socket, message)
    IO.puts("sent the message to server #{message}")
    :gen_tcp.close(socket)
  end
end
