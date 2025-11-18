defmodule MonadoTest do
  use ExUnit.Case
  doctest Monado

  test "greets the world" do
    assert Monado.hello() == :world
  end
end
