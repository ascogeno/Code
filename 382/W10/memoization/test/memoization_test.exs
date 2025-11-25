defmodule MemoizationTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, _pid} = Memoization.start_link(nil)
    :ok
  end

  test "computes and caches shipping cost for same input" do
    args = [10, 200]

    result1 = Memoization.get_or_compute(&Memoization.cost/2, args)
    result2 = Memoization.get_or_compute(&Memoization.cost/2, args)

    assert result1 == result2
  end

  test "returns different shipping cost for different input" do
    r1 = Memoization.get_or_compute(&Memoization.cost/2, [10, 200])
    r2 = Memoization.get_or_compute(&Memoization.cost/2, [20, 500])

    refute r1 == r2
  end
end
