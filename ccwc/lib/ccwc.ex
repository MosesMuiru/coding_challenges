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

    case OptionParser.parse(args,
           switches: [help: :boolean, character_count: :boolean],
           aliases: [h: :help, c: :character_count]
         ) do
      # {opts, _, _} -> execute(opts)
      {opts, filename, _} ->
        case do
          opts[:help] == true ->
            execute(:help)

          opts[:character_count] == true ->
            execute(:character_count)

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
    IO.puts("""
    --help
    for help

    ./ccwc filename
    this will read the file
    """)
  end

  def execute(:character_count) do
    IO.puts("""
    should count the number of character that are there
    """)
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

  # give you options of what should be counted
  # counting every character in that file
  def choose_option(file_content) do
    the_option = IO.gets "enter c-> character, w- word" |> String.trim()

    cond do
      the_option == c -> character_count(file_content)
      the_option == w -> word_count(file_content)


    end
  end

  # this will couting each word in the list
  def word_count(file_content) do
    String.length(file_content)
  end


  def character_count(file_content) do
    # this should count all the characters escaping including the spaces in the file
    file_content
    |> String.split(" ")
    |> counting()

  end

  def line_count(file_content) do
    
  end

  # this is for counting each character in the list
  def counting([]), do: 0
  def counting(list_content) do
    [head | tail] = list_content
    head + counting(tail)
  end

end
