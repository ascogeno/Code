# In your editor, implement a functional queue using the following structure: {list, list}. The queue should support two lists: one for the front elements and another for the rear elements.

# Implement all of the following functions:

# empty(queue):
# enqueue(queue, element):
# dequeue(queue):
# head(queue):
# tail(queue):
# toList(queue):
# fromList(list):

# Task Instructions:
# Use functional programming principles.
# Write tests to validate the correctness of each function.
# Ensure the queue adheres to the FIFO principle.
# Use recursive definitions wherever appropriate.
# Provide a test suite with multiple scenarios, including edge cases:
# Enqueuing and dequeuing elements in an empty queue.
# Accessing the head and tail of the queue at various stages.
# Converting between lists and queues.
# Combining multiple operations, such as enqueue and dequeue, sequentially.

# Please test your code to see if it works.

defmodule FunctionalQueue do
  @moduledoc """
  A purely functional queue implemented using two lists: {front, rear}.
  """

  # Create an empty queue
  def empty({[], []}), do: true
  def empty(_), do: false

  # Enqueue an element to the rear
  def enqueue({[], []}, element), do: {[element], []}
  def enqueue({front, rear}, element), do: {front, [element | rear]}

  # Dequeue an element from the front
  def dequeue({[], []}), do: {[], []}
  def dequeue({[head | []], rear}), do: {Enum.reverse(rear), []}
  def dequeue({[_ | tail], rear}), do: {tail, rear}

  # Head: Get the first element without removing
  def head({[], []}), do: nil
  def head({[], rear}), do: List.last(rear)
  def head({[h | _], _}), do: h

  # Tail: Get the last element without removing
  def tail({[], []}), do: nil
  def tail({[last], []}), do: last
  def tail({_, [h | _]}), do: h

  # Convert queue to list
  def to_list({front, rear}), do: front ++ Enum.reverse(rear)

  # Convert list to queue
  def from_list([]), do: {[], []}
  def from_list(list) when is_list(list), do: {list, []}

  # Optional: Reverse the queue
  def reverse({front, rear}), do: {Enum.reverse(rear), Enum.reverse(front)}

  # Optional: Get length of queue
  def length({front, rear}), do: Kernel.length(front) + Kernel.length(rear)
end
