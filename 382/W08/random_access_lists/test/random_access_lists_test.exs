defmodule RandomAccessListsTest do
  use ExUnit.Case
  alias RandomAccessLists

  test "empty check" do
    assert RandomAccessLists.empty([])
    refute RandomAccessLists.empty(RandomAccessLists.from_list([1]))
  end

  test "cons and head" do
    ral = RandomAccessLists.cons(10, [])
    assert RandomAccessLists.head(ral) == 10
  end

  test "tail returns the last value" do
    ral = RandomAccessLists.from_list([1, 2, 3])
    assert RandomAccessLists.tail(ral) == 3
  end

  test "lookup returns correct value" do
    ral = RandomAccessLists.from_list([10, 20, 30, 40])
    assert RandomAccessLists.lookup(ral, 0) == {:ok, 10}
    assert RandomAccessLists.lookup(ral, 3) == {:ok, 40}
    assert RandomAccessLists.lookup(ral, 4) == {:error, :out_of_bounds}
  end

  test "update modifies the correct index" do
    ral = RandomAccessLists.from_list([:a, :b, :c])
    {:ok, updated} = RandomAccessLists.update(ral, 1, :x)
    assert RandomAccessLists.lookup(updated, 1) == {:ok, :x}
  end

  test "toList and fromList round-trip" do
    input = Enum.to_list(1..10)
    ral = RandomAccessLists.from_list(input)
    assert RandomAccessLists.to_list(ral) == input
  end
end
