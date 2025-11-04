defmodule LeftistHeapTest do
  use ExUnit.Case
  alias LeftistHeap

  test "empty heap check" do
    assert LeftistHeap.empty(nil) == true
    heap = LeftistHeap.insert(nil, 5)
    assert LeftistHeap.empty(heap) == false
  end

  test "insert elements and find min" do
    heap = nil
    heap = LeftistHeap.insert(heap, 10)
    heap = LeftistHeap.insert(heap, 4)
    heap = LeftistHeap.insert(heap, 7)
    assert LeftistHeap.findMin(heap) == 4
  end

  test "delete min element" do
    heap = nil
    heap = LeftistHeap.insert(heap, 10)
    heap = LeftistHeap.insert(heap, 2)
    heap = LeftistHeap.insert(heap, 5)
    assert LeftistHeap.findMin(heap) == 2
    heap = LeftistHeap.deleteMin(heap)
    assert LeftistHeap.findMin(heap) == 5
  end

  test "merge two heaps" do
    heap1 = LeftistHeap.fromList([3, 7, 9])
    heap2 = LeftistHeap.fromList([1, 4, 8])
    merged = LeftistHeap.merge(heap1, heap2)
    assert LeftistHeap.toList(merged) == [1, 3, 4, 7, 8, 9]
  end

  test "toList returns sorted list" do
    heap = LeftistHeap.fromList([9, 3, 6, 1])
    assert LeftistHeap.toList(heap) == [1, 3, 6, 9]
  end

  test "fromList builds a valid heap" do
    list = [5, 2, 8, 1]
    heap = LeftistHeap.fromList(list)
    assert LeftistHeap.toList(heap) == Enum.sort(list)
  end

  test "handle duplicates" do
    heap = LeftistHeap.fromList([4, 2, 2, 4, 1])
    assert LeftistHeap.toList(heap) == [1, 2, 2, 4, 4]
  end

  test "inserting into and deleting from empty heap" do
    heap = nil
    heap = LeftistHeap.insert(heap, 42)
    assert LeftistHeap.findMin(heap) == 42
    heap = LeftistHeap.deleteMin(heap)
    assert LeftistHeap.empty(heap)
  end

  test "merging with empty heap" do
    heap1 = LeftistHeap.fromList([5, 10])
    merged = LeftistHeap.merge(heap1, nil)
    assert LeftistHeap.toList(merged) == [5, 10]
    merged = LeftistHeap.merge(nil, heap1)
    assert LeftistHeap.toList(merged) == [5, 10]
  end
end
