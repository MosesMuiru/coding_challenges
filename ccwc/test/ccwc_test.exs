defmodule CcwcTest do
  use ExUnit.Case
  doctest Ccwc

 test "the help function" do
  help = Ccwc.execute(:help)
  assert is_binary(help) == true
 end

 test "the execution given the filename" do
   {:ok, filecontent} = File.read("name.txt") # this will return ok and filecontent
  test_results = filecontent
   |> Ccwc.format_content

   results = execute("name.txt")

   assert test_results == results

 end
end
