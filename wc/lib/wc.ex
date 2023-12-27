defmodule Wc do


  def filename do
    IO.gets("enter file name")
    |> String.trim()
    |> format()
    |> character_count()
  end

  def format(filename) do
    case File.read(filename) do
      {:ok, file_content} ->
        file_content
        |> String.split(~r/\s+/)

      {:error, reason} -> reason
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
