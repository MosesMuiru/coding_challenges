defmodule Server do
  # here you insert the port which is automatically run in the supervisor 
  # the server should be the one sending the comback
  def connect(default_port) do
    {:ok, socket} = :gen_tcp.listen(default_port, [:binary, active: false, reuseaddr: true])
    IO.puts("stated the server at #{default_port} --> this is the pid")
    continues_connection(socket)
  end

  def continues_connection(socket) do
    {:ok, client_socket} = :gen_tcp.accept(socket)
    # should also
    receiving(client_socket)

    continues_connection(socket)
  end

# for receiving messagees/req from client
  def receiving(client_socket) do
    {:ok, sent_data} = :gen_tcp.recv(client_socket, 0)
    fetching_data(sent_data)
    |> send_resp(client_socket)

    IO.inspect(sent_data)
  end
# this is used to fetch data from the url --> return it to the client
  def fetching_data(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: _body}} ->
        IO.puts("status code: #{status_code}")

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

#   send response to the client
    def send_resp(client_socket, message) do

        
        IO.inspect(client_socket)
        :gen_tcp.send(client_socket, message)

        IO.puts "sent the resp"

        
    end

end
