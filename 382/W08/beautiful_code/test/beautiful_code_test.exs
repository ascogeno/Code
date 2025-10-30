defmodule BeautifulCodeTest do
  use ExUnit.Case
  doctest BeautifulCode

  test "greets the world" do
    assert BeautifulCode.hello() == :world
  end
end
