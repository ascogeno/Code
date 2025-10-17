defmodule DequeTest do
  use ExUnit.Case
  alias Deque

  test "empty deque" do
    d = {[], []}
    assert Deque.empty?(d)
    assert Deque.head(d) == nil
    assert Deque.tail(d) == nil
    assert Deque.dequeue(d) == {[], []}
    assert Deque.dequeue_back(d) == {[], []}
  end

  test "enqueue and head" do
    d1 = Deque.enqueue({[], []}, "a")
    assert Deque.to_list(d1) == ["a"]
    assert Deque.head(d1) == "a"
    assert Deque.tail(d1) == "a"
  end

  test "enqueue front" do
    d1 = Deque.enqueue({[], []}, "a")
    d2 = Deque.enqueue_front(d1, "b")
    assert Deque.to_list(d2) == ["b", "a"]
    assert Deque.head(d2) == "b"
    assert Deque.tail(d2) == "a"
  end

  test "dequeue" do
    d = {["b", "a"], []}
    d2 = Deque.dequeue(d)
    assert Deque.to_list(d2) == ["a"]
    assert Deque.head(d2) == "a"
  end

  test "dequeue back" do
    d = {["a"], []}
    d2 = Deque.dequeue_back(d)
    assert Deque.to_list(d2) == []
    assert Deque.empty?(d2)
  end

  test "from list and access" do
    d = Deque.from_list(["x", "y", "z"])
    assert Deque.to_list(d) == ["x", "y", "z"]
    assert Deque.head(d) == "x"
    assert Deque.tail(d) == "z"
  end

  test "sequential operations" do
    d0 = Deque.from_list([])
    d1 = Deque.enqueue(d0, "1")
    d2 = Deque.enqueue_front(d1, "0")
    d3 = Deque.enqueue(d2, "2")
    d4 = Deque.dequeue(d3)
    d5 = Deque.dequeue_back(d4)
    assert Deque.to_list(d5) == ["1"]
  end
end
