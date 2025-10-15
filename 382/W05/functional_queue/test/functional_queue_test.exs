#imma be very real, I had the FDS Gpt make these. but, i mean, looking at these, they're not the hardest things to set up
defmodule FunctionalQueueTest do
  use ExUnit.Case
  import FunctionalQueue

  test "empty queue" do
    assert empty({[], []}) == true
    assert head({[], []}) == nil
    assert tail({[], []}) == nil
    assert dequeue({[], []}) == {[], []}
  end

  test "enqueue elements" do
    q = {[], []}
    q = enqueue(q, 1)
    q = enqueue(q, 2)
    q = enqueue(q, 3)
    assert to_list(q) == [1, 2, 3]
    assert head(q) == 1
    assert tail(q) == 3
  end

  test "dequeue elements" do
    q = from_list([1, 2, 3])
    q = dequeue(q)
    assert to_list(q) == [2, 3]
    q = dequeue(q)
    assert to_list(q) == [3]
    q = dequeue(q)
    assert to_list(q) == []
  end

  test "convert to/from list" do
    q = from_list([10, 20, 30])
    assert to_list(q) == [10, 20, 30]
  end

  test "reverse and length" do
    q = from_list([5, 6, 7])
    assert reverse(q) |> to_list() == [7, 6, 5]
    assert FunctionalQueue.length(q) == 3
    assert FunctionalQueue.length({[], []}) == 0
  end
end
