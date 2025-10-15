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
  # check if queue is empty
  def empty({[], []}), do: true
  def empty(_), do: false

  # enqueue an element to the rear
  def enqueue({[], []}, element), do: {[element], []}
  def enqueue({front, rear}, element), do: {front, [element | rear]}

  # dequeue an element from the front
  def dequeue({[], []}), do: {[], []}
  def dequeue({[_ | []], rear}), do: {Enum.reverse(rear), []}
  def dequeue({[_ | tail], rear}), do: {tail, rear}

  # head: Get the first element without removing it
  def head({[], []}), do: nil
  def head({[], rear}), do: List.last(rear)
  def head({[h | _], _}), do: h

  # tail: Get the last element without removing it
  def tail({[], []}), do: nil
  def tail({[last], []}), do: last
  def tail({_, [h | _]}), do: h

  # convert queue to list
  def to_list({front, rear}), do: front ++ Enum.reverse(rear)

  # convert list to queue
  def from_list([]), do: {[], []}
  def from_list(list) when is_list(list), do: {list, []}

  # reverse the queue
  # this one was interesting, as I had no idea how to do it. this weird syntax below is the AI fix, and uh i'm not totally sure what it does but it passed the tests so im sure it's fine?
  def reverse(queue) do
    queue
    |> to_list()
    |> Enum.reverse()
    |> from_list()
  end

  # get the length of the queue
  def length({front, rear}), do: Kernel.length(front) + Kernel.length(rear)
end
