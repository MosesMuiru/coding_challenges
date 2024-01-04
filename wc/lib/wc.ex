defmodule Wc do

  def main(args \\ []) do
    args
    |> parse_args()
  end
# this should filter out the option that has been given out
@doc """
parse_arg ->
  help option -> help option
"""
  def parse_args(args) do
    # {opts, word, _} =
    args
    |> OptionParser.parse(switches: [help: :boolean], aliases: [h: :help])
    |> out_put()
    |> process_output()

  end

  def out_put(cmd_arg) do
    case cmd_arg do
      {[help: true], _, _} -> :help
      {_, [_w, filename], _ , _} -> { filename}
      _ -> IO.puts("the option does not exits")
        :help
    end
  end

  def process_output(:help) do
    IO.puts("""
      flag ---- usage

      -w  used to count the number of words in that file
      -c used to count the number of bytes in that file

    """)
  end

  def process_output({_w, file_path}) do
    file_path
     # IO.gets("enter file name")
    |> String.trim()
    |> format()
    |> word_count()
  end

  def filename do
    # IO.gets("enter file name")
    # |> String.trim()
    # |> format()
    # |> word_count()
  end

  def format(filename) do
    case File.read!(filename) do
      {:ok, file_content} ->
        file_content
        |> String.split(~r/\s+/)

      {:error, reason} -> IO.puts("msee error --> #{reason}")
    end
  end
  @doc """
  get the number of each words in a list of

  get the number of characters in each word

  assumin you have the following list of words

  Enum.each(words, fn word -> )
  """

  def word_count(file_content) do
    Enum.count(file_content, &String.length/1 )
  end

  def character_count([]), do: 0

  def character_count(file_content) do
    [head | tail] = file_content
    byte_size(head) + character_count(tail)

  end
end
