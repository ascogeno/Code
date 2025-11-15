defmodule MemoizationTest do
  use ExUnit.Case
  doctest Memoization

  test "greets the world" do
    assert Memoization.hello() == :world
  end
end
