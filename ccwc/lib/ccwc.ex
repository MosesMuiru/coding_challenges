defmodule Ccwc do
  @moduledoc """
  read from a file
  format the content
  """

  def main(args \\ []) do
    args
    |> parse_args()
  end

  # this is for parsing arg
  def parse_args(args) do
    # {opts, filename, _} =
    #  args
    # |> OptionParser.parse(switches: [help: :boolean])
    # {opts, filename}

    case OptionParser.parse(args, switches: [help: :boolean]) do
      # {opts, _, _} -> execute(opts)
      {opts, filename, _} ->
        case opts[:help] do
          true ->
            execute(:help)

          _ ->
            filename
            |> List.to_string()
            |> execute()
        end

      _ ->
        IO.puts("check you input")
    end
  end

  # this used to proocess the incomming args from the parse
  def out_put(cmd_args) do
    case cmd_args do
      {[:help, true], _, _} -> :help
      _ -> IO.puts(" there is an error in the input")
    end
  end

  # executive
  def execute(:help) do
    IO.puts """
    --help
    for help

    ./ccwc filename
    this will read the file 
    """
  end

  def execute(filename) do
    filename
    |> read_file()
    |> format_content()
    |> IO.puts()
  end

  def read_file(filename) do
    case File.read(filename) do
      {:ok, file_content} -> file_content
      {:error, reason} -> reason
    end
  end

  def format_content(file_content) do
    String.replace(file_content, "\n", "")
    |> String.replace("\r", "")
  end
end
