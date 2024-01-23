defmodule Server do

    # here you insert the port which is automatically run in the supervisor 
    # the server should be the one sending the comback
    def connect(default_port) do
       
        {:ok, socket} = :gen_tcp.listen( default_port, [:binary, active: false, reuseaddr: true])
        IO.puts("stated the server at #{default_port} --> this is the pid")
        continues_connection(socket)
    end

    def continues_connection(socket) do
        {:ok, client_socket} = :gen_tcp.accept(socket)
        # should also
        receiving(client_socket)
        continues_connection(socket)
        
    end

    def receiving(client_socket) do
        {:ok, sent_data} = :gen_tcp.recv(client_socket, 0)
        fetching_data(sent_data)

        IO.inspect(sent_data)

    end

    def fetching_data(sent_data) do
        

    end

    
end