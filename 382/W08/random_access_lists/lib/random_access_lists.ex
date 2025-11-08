# ChatGPT link for non condensed milk: https://chatgpt.com/share/690ec0dd-72d4-8004-b337-18a57d48f5c4

# Functional Requirements:

# empty(ralist)
# cons(element, ralist)
# head(ralist)
# tail(ralist)
# lookup(ralist, index)
# Edge Case: Handle out-of-bounds indices properly
# update(ralist, index, newValue)
# toList(ralist)
# fromList(list)

# Task Instructions:

# Implement the above functions using functional programming principles.
# Utilize recursive definitions wherever appropriate.
# Write tests to validate the correctness of each function.
# Handle edge cases, such as:
# Accessing or updating an index that is out-of-bounds
# Converting an empty list
# Repeated addition or removal of elements

# Please test your code to see if it works.

defmodule RandomAccessLists do
  defmodule Tree do
    defstruct [:size, :value, :left, :right]
  end

  @type tree :: %Tree{
          size: non_neg_integer(),
          value: any(),
          left: tree() | nil,
          right: tree() | nil
        }
  @type ralist :: [tree()]

  # Check if the RAL is empty
  def empty([]), do: true
  def empty(_), do: false

  # Convert a standard list into a RAL
  def from_list(list), do: Enum.reduce(Enum.reverse(list), [], fn el, acc -> cons(el, acc) end)

  # Convert a RAL back to a list of elements
  def to_list(ral), do: Enum.flat_map(ral, &flatten/1)

  defp flatten(%Tree{left: nil, right: nil, value: v}), do: [v]
  defp flatten(%Tree{left: l, right: r}), do: flatten(l) ++ flatten(r)

  # Add an element to the front of the RAL
  def cons(x, ral), do: insert_tree(%Tree{size: 1, value: x, left: nil, right: nil}, ral)

  defp insert_tree(t1, [%Tree{size: s} = t2 | rest]) when t1.size == s do
    merged = %Tree{
      size: t1.size + t2.size,
      value: nil,
      left: t1,
      right: t2
    }

    insert_tree(merged, rest)
  end

  defp insert_tree(t, ral), do: [t | ral]

  # Get the first element (leftmost leaf)
  def head([]), do: nil
  def head([tree | _]), do: leftmost(tree)

  defp leftmost(%Tree{left: nil, value: v}), do: v
  defp leftmost(%Tree{left: l}), do: leftmost(l)

  # Get the last element (rightmost leaf)
  def tail([]), do: nil
  def tail(ralist), do: rightmost(Enum.reverse(ralist) |> hd())

  defp rightmost(%Tree{right: nil, value: v}), do: v
  defp rightmost(%Tree{right: r}), do: rightmost(r)

  # Lookup an element by index
  def lookup(_ral, index) when index < 0, do: {:error, :out_of_bounds}
  def lookup(ral, index), do: do_lookup(ral, index)

  defp do_lookup([], _), do: {:error, :out_of_bounds}

  defp do_lookup([%Tree{size: s} = t | rest], index) do
    if index < s do
      lookup_tree(t, index)
    else
      do_lookup(rest, index - s)
    end
  end

  defp lookup_tree(%Tree{left: nil, right: nil, value: v}, 0), do: {:ok, v}
  defp lookup_tree(%Tree{left: nil, right: nil}, _), do: {:error, :out_of_bounds}

  defp lookup_tree(%Tree{left: l, right: _}, i) when l != nil and i < l.size,
    do: lookup_tree(l, i)

  defp lookup_tree(%Tree{left: l, right: r}, i) when r != nil, do: lookup_tree(r, i - l.size)
  defp lookup_tree(_, _), do: {:error, :out_of_bounds}

  # Update an element at a specific index
  def update(_ral, index, _value) when index < 0, do: {:error, :out_of_bounds}
  def update(ral, index, value), do: do_update(ral, index, value)

  defp do_update([], _, _), do: {:error, :out_of_bounds}

  defp do_update([%Tree{size: s} = t | rest], index, value) do
    if index < s do
      case update_tree(t, index, value) do
        {:ok, new_tree} -> {:ok, [new_tree | rest]}
        error -> error
      end
    else
      case do_update(rest, index - s, value) do
        {:ok, updated_tail} -> {:ok, [t | updated_tail]}
        error -> error
      end
    end
  end

  defp update_tree(%Tree{left: nil, right: nil} = leaf, 0, val),
    do: {:ok, %Tree{leaf | value: val}}

  defp update_tree(%Tree{left: nil, right: nil}, _, _),
    do: {:error, :out_of_bounds}

  defp update_tree(%Tree{left: l, right: _} = t, i, val) when l != nil and i < l.size do
    case update_tree(l, i, val) do
      {:ok, new_l} -> {:ok, %Tree{t | left: new_l}}
      error -> error
    end
  end

  defp update_tree(%Tree{left: l, right: r} = t, i, val) when r != nil do
    case update_tree(r, i - l.size, val) do
      {:ok, new_r} -> {:ok, %Tree{t | right: new_r}}
      error -> error
    end
  end

  defp update_tree(_, _, _), do: {:error, :out_of_bounds}
end
