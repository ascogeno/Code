defmodule BeautifulCodeTest do
  use ExUnit.Case, async: true
  alias BeautifulCode

  describe "sum_of_even_squares/1" do
    test "returns 0 for empty list" do
      assert BeautifulCode.sum_of_even_squares([]) == 0
    end

    test "returns 0 when no even numbers" do
      assert BeautifulCode.sum_of_even_squares([1, 3, 5]) == 0
    end

    test "sums squares of even numbers" do
      assert BeautifulCode.sum_of_even_squares([1, 2, 3, 4]) == 20
    end

    test "handles negative numbers correctly" do
      assert BeautifulCode.sum_of_even_squares([-4, -3, -2, -1]) == 20
    end

    test "handles all even numbers" do
      assert BeautifulCode.sum_of_even_squares([2, 4, 6]) == 4 + 16 + 36
    end
  end
end
