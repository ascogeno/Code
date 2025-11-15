defmodule FactoryPatternTest do
  use ExUnit.Case
  doctest FactoryPattern

  test "greets the world" do
    assert FactoryPattern.hello() == :world
  end
end
