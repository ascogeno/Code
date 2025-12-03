defmodule ETSTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, _pid} = ETS.start_link()
    :ok
  end

  test "increments and retrieves counters" do
    assert ETS.get(:a) == 0
    assert ETS.increment(:a) == 1
    assert ETS.increment(:a) == 2
    assert ETS.get(:a) == 2
  end

  test "different keys maintain independent counters" do
    ETS.increment(:x)
    ETS.increment(:y)
    ETS.increment(:x)

    assert ETS.get(:x) == 2
    assert ETS.get(:y) == 1
  end
end
