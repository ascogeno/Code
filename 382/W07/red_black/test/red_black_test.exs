defmodule RedBlackTest do
  use ExUnit.Case
  alias RedBlack

  describe "empty/1" do
    test "returns true for nil" do
      assert RedBlack.empty(nil) == true
    end

    test "returns false for a non-empty tree" do
      tree = RedBlack.fromList([10])
      assert RedBlack.empty(tree) == false
    end
  end

  describe "contains/2" do
    setup do
      tree = RedBlack.fromList([10, 5, 15])
      %{tree: tree}
    end

    test "finds existing value", %{tree: tree} do
      assert RedBlack.contains(tree, 5)
      assert RedBlack.contains(tree, 10)
    end

    test "returns false for non-existent value", %{tree: tree} do
      refute RedBlack.contains(tree, 99)
    end
  end

  describe "add/2" do
    test "adds a single value to an empty tree" do
      tree = RedBlack.add(nil, 42)
      assert RedBlack.contains(tree, 42)
      assert RedBlack.toList(tree) == [42]
    end

    test "adds multiple values and maintains sorted order" do
      tree = RedBlack.fromList([10, 5, 15])
      new_tree = RedBlack.add(tree, 7)
      assert RedBlack.toList(new_tree) == [5, 7, 10, 15]
    end
  end

  describe "remove/2" do
    test "removes a leaf node" do
      tree = RedBlack.fromList([10, 5, 15])
      new_tree = RedBlack.remove(tree, 5)
      refute RedBlack.contains(new_tree, 5)
      assert RedBlack.toList(new_tree) == [10, 15]
    end

    test "removes node with one child" do
      tree = RedBlack.fromList([10, 5, 15, 12])
      new_tree = RedBlack.remove(tree, 15)
      assert RedBlack.toList(new_tree) == [5, 10, 12]
    end

    test "removes node with two children" do
      tree = RedBlack.fromList([10, 5, 15, 12])
      new_tree = RedBlack.remove(tree, 10)
      assert RedBlack.toList(new_tree) == [5, 12, 15]
    end
  end

  describe "min/1 and max/1" do
    test "returns correct min and max" do
      tree = RedBlack.fromList([10, 5, 15, 2, 20])
      assert RedBlack.min(tree) == 2
      assert RedBlack.max(tree) == 20
    end

    test "returns nil for empty tree" do
      assert RedBlack.min(nil) == nil
      assert RedBlack.max(nil) == nil
    end
  end

  describe "toList/1 and fromList/1" do
    test "converts tree to sorted list" do
      tree = RedBlack.fromList([10, 5, 15])
      assert RedBlack.toList(tree) == [5, 10, 15]
    end

    test "builds tree from list and maintains ordering" do
      list = [8, 3, 10, 1, 6]
      tree = RedBlack.fromList(list)
      assert RedBlack.toList(tree) == Enum.sort(list)
    end
  end
end
