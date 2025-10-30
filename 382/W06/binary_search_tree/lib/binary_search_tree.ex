# More full list: https://chatgpt.com/share/68f84f8c-e2ec-8004-918a-8456905717d5
# In your editor, implement the following functions for a Binary Search Tree (BST) using the structure {value, next_left, next_right}:

# Functional Requirements:
# empty(bst)
# add(bst, element)
# contains(bst, element)
# remove(bst, element)
# min(bst)
# max(bst)
# toList(bst)
# fromList(list)
# height(bst)
# isBalanced(bst)

# Task Instructions:
# Use functional programming principles.
# Implement recursive definitions where appropriate.
# Write a test suite that includes:
# Adding to an empty BST
# Removing the root, leaf nodes, and nodes with one or two children
# Searching for elements at different depths
# Converting between lists and BSTs
# Please test your code to see if it works.

defmodule BinarySearchTree do
  # 1. Check if the tree is empty
  def empty(nil), do: true
  def empty({_value, _left, _right}), do: false

  # 2. Add an element to the BST
  def add(nil, element), do: {element, nil, nil}
  def add({value, left, right}, element) when element < value do
    {value, add(left, element), right}
  end
  def add({value, left, right}, element) do
    {value, left, add(right, element)}
  end

  # 3. Check if element is in BST
  def contains(nil, _element), do: false
  def contains({value, _left, _right}, element) when element == value, do: true
  def contains({value, left, _right}, element) when element < value, do: contains(left, element)
  def contains({_value, _left, right}, element), do: contains(right, element)

  # 4. Find the minimum value in the BST
  def min(nil), do: nil
  def min({value, nil, _}), do: value
  def min({_, left, _}), do: min(left)

  # 5. Find the maximum value in the BST
  def max(nil), do: nil
  def max({value, _, nil}), do: value
  def max({_, _, right}), do: max(right)

  # 6. Convert BST to sorted list (in-order traversal)
  def to_list(nil), do: []
  def to_list({value, left, right}), do: to_list(left) ++ [value] ++ to_list(right)

  # 7. Build BST from list
  def from_list([]), do: nil
  def from_list([h | t]), do: Enum.reduce(t, add(nil, h), &add(&2, &1))

  # 8. Remove an element from the BST
  def remove(nil, _element), do: nil
  def remove({value, left, right}, element) when element < value do
    {value, remove(left, element), right}
  end
  def remove({value, left, right}, element) when element > value do
    {value, left, remove(right, element)}
  end
  def remove({_value, left, right}, _element) do
    case {left, right} do
      {nil, nil} -> nil
      {nil, _} -> right
      {_, nil} -> left
      _ ->
        successor = min(right)
        {successor, left, remove(right, successor)}
    end
  end

  # 9. Height of BST
  def height(nil), do: 0
  def height({_, left, right}), do: 1 + max(height(left), height(right))

  # 10. Check if tree is balanced
  def is_balanced(nil), do: true
  def is_balanced({_, left, right}) do
    abs(height(left) - height(right)) <= 1 and is_balanced(left) and is_balanced(right)
  end
end
