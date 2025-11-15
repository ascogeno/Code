defmodule LazyTest do
  use ExUnit.Case
  doctest Lazy

  test "greets the world" do
    assert Lazy.hello() == :world
  end
end
