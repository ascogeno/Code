# These instructions are condensed, see this link for more full instructions: https://chatgpt.com/share/6909a4c7-ec18-8004-80b7-6a6d98243916
# In your editor, implement the following functions for a Leftist Min-Heap:

# empty(heap)
# insert(heap, element)
# findMin(heap)
# deleteMin(heap)
# merge(heap1, heap2)
# toList(heap)
# fromList(list)

# You must:

# Use functional programming principles.
# Utilize recursive definitions where appropriate, particularly in the merge, insert, and deleteMin functions.
# Write comprehensive tests to validate each function.

# Include edge cases such as:
# Inserting into or deleting from an empty heap.
# Merging an empty heap with a non-empty heap.
# Handling duplicate elements.
# Please test your code to see if it works.

defmodule LeftistHeap do
  defstruct rank: 1, value: nil, left: nil, right: nil

  # Check if the heap is empty
  def empty(nil), do: true
  def empty(_), do: false

  # Return the rank of a heap node
  defp rank(nil), do: 0
  defp rank(%LeftistHeap{rank: r}), do: r

  # Merge two heaps
  def merge(nil, heap), do: heap
  def merge(heap, nil), do: heap

  def merge(h1 = %LeftistHeap{value: v1, left: l1, right: r1},
            h2 = %LeftistHeap{value: v2}) do
    if v1 <= v2 do
      merged = merge(r1, h2)
      make_node(v1, l1, merged)
    else
      merge(h2, h1)
    end
  end

  # Build a node and maintain leftist property
  defp make_node(value, left, right) do
    if rank(left) >= rank(right) do
      %LeftistHeap{value: value, left: left, right: right, rank: rank(right) + 1}
    else
      %LeftistHeap{value: value, left: right, right: left, rank: rank(left) + 1}
    end
  end

  # Insert by merging singleton node with heap
  def insert(heap, value) do
    merge(%LeftistHeap{value: value, left: nil, right: nil, rank: 1}, heap)
  end

  # Find min (the root value)
  def findMin(nil), do: nil
  def findMin(%LeftistHeap{value: v}), do: v

  # Delete min (remove root and merge its children)
  def deleteMin(nil), do: nil
  def deleteMin(%LeftistHeap{left: l, right: r}), do: merge(l, r)

  # Convert heap to sorted list
  def toList(heap), do: to_list_recursive(heap, [])

  defp to_list_recursive(nil, acc), do: Enum.reverse(acc)
  defp to_list_recursive(heap, acc) do
    to_list_recursive(deleteMin(heap), [findMin(heap) | acc])
  end

  # Build heap from list
  def fromList([]), do: nil
  def fromList([h | t]), do: insert(fromList(t), h)
end
