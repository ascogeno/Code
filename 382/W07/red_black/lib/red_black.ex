# In your editor, implement the following functions for a Red-Black Tree using the structure {color, value, next_left, next_right}:

# Functional Requirements:
# empty(rbt)
# add(rbt, element)
# contains(rbt, element)
# remove(rbt, element)
# min(rbt)
# max(rbt)
# toList(rbt)
# fromList(list)
# Please test your code to see if it works.

#This is a consise version of the instructions given here: https://chatgpt.com/share/6903e905-5cf8-8004-84f8-b04471f03e48

defmodule RedBlack do
  @type color :: :red | :black
  @type rbt_node :: {color, any(), tree(), tree()}
  @type tree :: rbt_node | nil

  # empty feeling (checks for empty trees)
  # i guess i could have made a deforestry joke
  def empty(nil), do: true
  def empty(_), do: false

  # cheque cashing. checking for values
  def contains(nil, _val), do: false
  def contains({_, value, left, right}, val) do
    cond do
      val == value -> true
      val < value -> contains(left, val)
      true -> contains(right, val)
    end
  end

  # an additional function
  def add(tree, val) do
    {_, v, l, r} = add_helper(tree, val)
    {:black, v, l, r}
  end

  # helper functions n such. this is where most of the magic is. and I say magic, this was vibe-coded all day
  defp add_helper(nil, val), do: {:red, val, nil, nil}
  defp add_helper({color, value, left, right}, val) do
    if val < value do
      balance_left({color, value, add_helper(left, val), right})
    else
      balance_right({color, value, left, add_helper(right, val)})
    end
  end

  defp balance_left({:black, val, {:red, a_val, {:red, b_val, b_left, b_right}, a_right}, right}) do
    {:red, a_val, {:black, b_val, b_left, b_right}, {:black, val, a_right, right}}
  end
  defp balance_left({:black, val, {:red, a_val, a_left, {:red, b_val, b_left, b_right}}, right}) do
    {:red, b_val, {:black, a_val, a_left, b_left}, {:black, val, b_right, right}}
  end
  defp balance_left(node), do: node

  defp balance_right({:black, val, left, {:red, a_val, a_left, {:red, b_val, b_left, b_right}}}) do
    {:red, a_val, {:black, val, left, a_left}, {:black, b_val, b_left, b_right}}
  end
  defp balance_right({:black, val, left, {:red, a_val, {:red, b_val, b_left, b_right}, a_right}}) do
    {:red, b_val, {:black, val, left, b_left}, {:black, a_val, b_right, a_right}}
  end
  defp balance_right(node), do: node

  # removing stuff? funny the competensee wants this, but the dipper didn't ask about this function
  def remove(nil, _val), do: nil
  def remove({color, value, left, right}, val) do
    cond do
      val < value ->
        {color, value, remove(left, val), right}
      val > value ->
        {color, value, left, remove(right, val)}
      true ->
        delete_node({color, value, left, right})
    end
  end

  defp delete_node({_, _, nil, nil}), do: nil
  defp delete_node({_color, _value, left, nil}), do: left
  defp delete_node({_color, _value, nil, right}), do: right
  defp delete_node({color, _value, left, right}) do
    min_val = min(right)
    new_right = remove(right, min_val)
    {color, min_val, left, new_right}
  end

  # also not something the dipper asked for. weird how the competensee is more thorough than the dipper
  def min(nil), do: nil
  def min({_, value, nil, _}), do: value
  def min({_, _, left, _}), do: min(left)

  # max galactica
  def max(nil), do: nil
  def max({_, value, _, nil}), do: value
  def max({_, _, _, right}), do: max(right)

  # want the tree in a list? i don't but the competensee does
  def toList(nil), do: []
  def toList({_, value, left, right}) do
    toList(left) ++ [value] ++ toList(right)
  end

  # want a tree from a list? i certainly might but the compentensee does
  def fromList(list), do: Enum.reduce(list, nil, fn x, acc -> add(acc, x) end)
end
