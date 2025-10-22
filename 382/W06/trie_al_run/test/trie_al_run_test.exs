ExUnit.start()

defmodule TrieAlRunTest do
  use ExUnit.Case
  alias Trie

  test "add and contains?" do
    trie =
      Trie.new()
      |> Trie.add(~w(c a t))
      |> Trie.add(~w(c a r))
      |> Trie.add(~w(d o g))
      |> Trie.add(~w(c a))

    assert Trie.contains?(trie, ~w(c a t)) == true
    assert Trie.contains?(trie, ~w(c a r)) == true
    assert Trie.contains?(trie, ~w(d o g)) == true
    assert Trie.contains?(trie, ~w(c a)) == true
    assert Trie.contains?(trie, ~w(c o w)) == false
    assert Trie.contains?(trie, []) == false
  end

  test "to_list returns all sequences" do
    trie =
      Trie.new()
      |> Trie.add(~w(c a t))
      |> Trie.add(~w(c a r))
      |> Trie.add(~w(d o g))
      |> Trie.add(~w(c a))

    expected = [
      ~w(c a t),
      ~w(c a r),
      ~w(d o g),
      ~w(c a)
    ]

    assert Enum.sort(Trie.to_list(trie)) == Enum.sort(expected)
  end

  test "prefix returns sequences with matching prefix" do
    trie =
      Trie.new()
      |> Trie.add(~w(c a t))
      |> Trie.add(~w(c a r))
      |> Trie.add(~w(d o g))
      |> Trie.add(~w(c a))

    assert Enum.sort(Trie.prefix(trie, ~w(c a))) == Enum.sort([
             ~w(c a t),
             ~w(c a r),
             ~w(c a)
           ])

    assert Trie.prefix(trie, ~w(d)) == [~w(d o g)]
    assert Trie.prefix(trie, ~w(x)) == []
  end

  test "remove deletes only the exact sequence" do
    trie =
      Trie.new()
      |> Trie.add(~w(c a t))
      |> Trie.add(~w(c a r))
      |> Trie.add(~w(d o g))
      |> Trie.add(~w(c a))

    updated = Trie.remove(trie, ~w(c a))

    assert Trie.contains?(updated, ~w(c a)) == false
    assert Trie.contains?(updated, ~w(c a t)) == true
    assert Enum.sort(Trie.to_list(updated)) == Enum.sort([
             ~w(c a t),
             ~w(c a r),
             ~w(d o g)
           ])
  end

  test "remove_prefix deletes all sequences starting with prefix" do
    trie =
      Trie.new()
      |> Trie.add(~w(c a t))
      |> Trie.add(~w(c a r))
      |> Trie.add(~w(d o g))

    updated = Trie.remove_prefix(trie, ~w(c a))
    assert Trie.to_list(updated) == [~w(d o g)]
  end

  test "size counts all complete sequences" do
    trie =
      Trie.new()
      |> Trie.add(~w(a))
      |> Trie.add(~w(a b))
      |> Trie.add(~w(b))

    assert Trie.size(trie) == 3

    reduced = Trie.remove(trie, ~w(a))
    assert Trie.size(reduced) == 2
  end

  test "from_list builds a trie from list of sequences" do
    list = [~w(a), ~w(a b), ~w(b)]
    trie = Trie.from_list(list)
    assert Enum.sort(Trie.to_list(trie)) == Enum.sort(list)
  end
end
