defmodule MonadoTest do
  use ExUnit.Case
  alias Monado

  def add_one(x), do: {x + 1, ["Added one"]}
  def double(x), do: {x * 2, ["Doubled the value"]}

  test "unit wraps a value with empty log" do
    assert Monado.unit(5) == {5, []}
  end

  test "bind chains functions and combines logs" do
    result =
      Monado.unit(3)
      |> Monado.bind(&add_one/1)
      |> Monado.bind(&double/1)

    assert result == {8, ["Added one", "Doubled the value"]}
  end
end
