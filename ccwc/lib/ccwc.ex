defmodule Ccwc do
  @moduledoc """
  read from a file
  format the content
  """

  def main(args \\ []) do
    args
    |> parse_args()
    |> out_put()
  end

  # this is for parsing arg
  def parse_args(args) do


    # the corrected version
    {opts, filename, _} =
      args
      |> OptionParser.parse(
        switches: [help: :boolean, character: :boolean, word: :boolean],
        aliases: [h: :help, c: :character, w: :word]
      )

    {opts, List.to_string(filename)}
  end

  # this used to proocess the incomming args from the parse
  def out_put(cmd_args) do
    # IO.inspect(cmd_args)
    case cmd_args do
      {[help: true], _} -> execute(:help)
      {[character: true], filename} -> execute(:character, filename)
      {[word: true], filename} -> execute(:word, filename)
      _-> IO.puts("this is for other wise")
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

  def execute(:character, filename) do
    IO.puts("this is working")

  formatted_file = filename
    |> file_formating()

  character_count(formatted_file)

  end

  def execute(:word, filename) do
    formatted_file = filename
    |> file_formating()

    word_count(formatted_file)
  end
  def file_formating(filename) do
    filename
    |> read_file()
    |> format_content()

  end

  def read_file(filename ) do
    case File.read(filename) do
      {:ok, file_content} -> file_content
      {:error, reason} -> reason
    end
  end

  def format_content(file_content) do
    String.replace(file_content, "\n", "")
    |> String.replace("\r", "")
    |> String.replace("\uFEFF", "")
  end

  # give you options of what should be counted
  # counting every character in that file
  def choose_option(file_content) do
    the_option = IO.gets("enter c-> character, w- word" |> String.trim())

    cond do
      the_option == "c" -> character_count(file_content)
      the_option == "w" -> word_count(file_content)
    end
  end

  # this will couting each word in the list
  def word_count(file_content) do
    String.split(file_content)
    |> length()
    |> IO.puts()

  end

  def character_count(file_content) do

    # this should count all the characters escaping including the spaces in the file
    file_content
    |> String.split(" ")
    |> count()
    |> IO.puts()
  end

  def count([]), do: 0
  def count(file_content) do

    # get the individual woed in the list
    [head | tail] = file_content
     String.length(head) + count(tail)

  #  IO.puts("the word count --> #{the_count}")
  end

  # def line_count(file_co/)

  # this is for counting each character in the list
  def counting([_ | tail]), do: tail

  def counting(list_content) do
    [head | tail] = list_content
    # this will get the individual elements in the list

  the_count = head + counting(tail)
  IO.puts("the cont #{the_count}")
  end
end
