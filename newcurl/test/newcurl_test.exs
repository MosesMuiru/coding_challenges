defmodule NewcurlTest do
  use ExUnit.Case
  doctest Newcurl

  test "greets the world" do
    assert Newcurl.hello() == :world
  end
end
