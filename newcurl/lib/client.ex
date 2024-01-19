defmodule Client do

    def connect(port, message) do
        {:ok, socket} = :gen_tcp.connect("localhost", port, [:binary, active: false], reuseaddr: false)
        IO.puts("server connected at #{socket}")
        send_data(socket, message)
    end

    def send_data(socket, message) do
        :gen_tcp.send(socket, message)
        :gen_tcp.close(socket)
    end
end