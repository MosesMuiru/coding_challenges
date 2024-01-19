defmodule Server do
    
    def connect(default_port) do
       
        {:ok, socket} = :gen_tcp.listen( default_port, [:binary, active: false, reuseaddr: true])
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

        IO.inspect(sent_data)

    end


    
end