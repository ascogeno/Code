# In your editor, implement all of the following functions for a functional deque using the structure {list, list} — one list for the front elements, and another for the rear elements:

# Functional Requirements:
# empty(deque):
# enqueue(deque, element):
# enqueue_front(deque, element):
# dequeue(deque):
# dequeue_back(deque):
# head(deque):
# tail(deque):
# toList(deque):
# fromList(list):
# Task Instructions:
# Use functional programming principles.
# Write tests for each function.
# Use recursive definitions wherever appropriate.
# Include multiple test scenarios, including edge cases such as:
# Enqueuing and dequeuing on an empty deque.
# Accessing the head and tail at various stages.
# Converting between lists and deques.
# Sequential combinations like enqueue, dequeue, and enqueue_front.

defmodule Deque do
  @type t :: {list(), list()}

  @spec empty?(t) :: boolean()
  def empty?({[], []}), do: true
  def empty?(_), do: false

  @spec enqueue(t, any) :: t
  def enqueue({[], []}, element), do: {[element], []}
  def enqueue({front, rear}, element), do: {front, [element | rear]}

  @spec enqueue_front(t, any) :: t
  def enqueue_front({front, rear}, element), do: {[element | front], rear}

  @spec dequeue(t) :: t
  def dequeue({[], []}), do: {[], []}
  def dequeue({[_], rear}), do: {Enum.reverse(rear), []}
  def dequeue({[_ | t], rear}), do: {t, rear}

  @spec dequeue_back(t) :: t
  def dequeue_back({[], []}), do: {[], []}
  def dequeue_back({[], [_]}), do: {[], []}
  def dequeue_back({front, [_ | t]}), do: {front, t}
  def dequeue_back({front, []}) do
    case Enum.reverse(front) do
      [] -> {[], []}
      [_] -> {[], []}
      list -> {Enum.reverse(tl(list)), []}
    end
  end

  @spec head(t) :: any | nil
  def head({[], []}), do: nil
  def head({[], rear}), do: List.last(rear)
  def head({[h | _], _}), do: h

  @spec tail(t) :: any | nil
  def tail({[], []}), do: nil
  def tail({front, []}), do: List.last(front)
  def tail({_, [h | _]}), do: h

  @spec to_list(t) :: list()
  def to_list({front, rear}), do: front ++ Enum.reverse(rear)

  @spec from_list(list()) :: t
  def from_list([]), do: {[], []}
  def from_list(list), do: {list, []}
end
