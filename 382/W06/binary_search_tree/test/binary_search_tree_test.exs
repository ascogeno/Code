defmodule BinarySearchTreeTest do
  use ExUnit.Case
  alias BinarySearchTree

  test "empty tree check" do
    assert BinarySearchTree.empty(nil) == true
    assert BinarySearchTree.empty({10, nil, nil}) == false
  end

  test "add and contains" do
    tree = BinarySearchTree.add(nil, 10)
    tree = BinarySearchTree.add(tree, 5)
    tree = BinarySearchTree.add(tree, 15)

    assert BinarySearchTree.contains(tree, 10)
    assert BinarySearchTree.contains(tree, 5)
    assert BinarySearchTree.contains(tree, 15)
    refute BinarySearchTree.contains(tree, 42)
  end

  test "min and max values" do
    tree = [20, 10, 30, 5, 25] |> BinarySearchTree.from_list()

    assert BinarySearchTree.min(tree) == 5
    assert BinarySearchTree.max(tree) == 30
  end

  test "toList and fromList conversion" do
    list = [10, 5, 15, 3, 7]
    tree = BinarySearchTree.from_list(list)
    assert BinarySearchTree.to_list(tree) == Enum.sort(list)
  end

  test "remove leaf node" do
    tree = [10, 5, 15] |> BinarySearchTree.from_list()
    tree = BinarySearchTree.remove(tree, 5)

    refute BinarySearchTree.contains(tree, 5)
    assert BinarySearchTree.contains(tree, 10)
    assert BinarySearchTree.contains(tree, 15)
  end

  test "remove node with one child" do
    tree = [10, 5, 15, 12] |> BinarySearchTree.from_list()
    tree = BinarySearchTree.remove(tree, 15)

    refute BinarySearchTree.contains(tree, 15)
    assert BinarySearchTree.contains(tree, 12)
  end

  test "remove node with two children" do
    tree = [10, 5, 15, 12, 17] |> BinarySearchTree.from_list()
    tree = BinarySearchTree.remove(tree, 15)

    refute BinarySearchTree.contains(tree, 15)
    assert BinarySearchTree.contains(tree, 12)
    assert BinarySearchTree.contains(tree, 17)
  end

  test "height calculation" do
    assert BinarySearchTree.height(nil) == 0
    assert BinarySearchTree.height(BinarySearchTree.from_list([10])) == 1
    assert BinarySearchTree.height(BinarySearchTree.from_list([10, 5, 15])) == 2
  end

  test "balanced check" do
    assert BinarySearchTree.is_balanced(BinarySearchTree.from_list([10, 5, 15])) == true
    assert BinarySearchTree.is_balanced({10, {5, {3, nil, nil}, nil}, nil}) == false
  end
end
