defmodule StatePatternTest do
  use ExUnit.Case
  doctest StatePattern

  test "greets the world" do
    assert StatePattern.hello() == :world
  end
end
