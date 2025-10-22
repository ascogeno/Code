# Data CompetentSee said (abbreviated. Full link: https://chatgpt.com/share/68f6ae2b-d6f8-8004-b5b2-b86790cc9056):

# In your editor, implement a Trie data structure with the following functional requirements:
# empty(trie):
# add(trie, sequence):
# contains(trie, sequence):
# remove(trie, sequence):
# prefix(trie, prefix):
# toList(trie):
# fromList(list):

# Task Instructions:
# Implement all functions using functional programming principles.
# Use recursive definitions where appropriate.
# Write tests to validate the correctness of each function.
# Handle edge cases, such as:
# Adding duplicate sequences.
# Removing sequences that are prefixes of others.
# Handling empty sequences or prefixes.
# Optimize prefix and contains for efficiency, ensuring minimal traversal.

# Please test your code to see if it works.


defmodule Trie do

  @end_marker :end

  # ========== Public API ==========

  def new(), do: %{}

  def empty?(trie), do: map_size(trie) == 0

  def add(trie, []), do: Map.put(trie, @end_marker, nil)

  def add(trie, [h | t]) do
    subtrie = Map.get(trie, h, %{})
    updated = add(subtrie, t)
    Map.put(trie, h, updated)
  end

  def contains?(trie, []), do: Map.has_key?(trie, @end_marker)

  def contains?(trie, [h | t]) do
    case Map.get(trie, h) do
    nil -> false
    subtrie -> contains?(subtrie, t)
    end
  end

  def remove(trie, []), do: Map.delete(trie, @end_marker)

  def remove(trie, [h | t]) do
    case Map.get(trie, h) do
      nil -> trie
      subtrie ->
        updated = remove(subtrie, t)
        result =
          if map_size(updated) == 0 and not Map.has_key?(trie, @end_marker) do
            Map.delete(trie, h)
          else
            Map.put(trie, h, updated)
          end

        result
    end
  end

  def to_list(trie), do: flatten_with_prefix([], trie)

  def from_list([]), do: new()
  def from_list([seq | rest]), do: add(from_list(rest), seq)

  def prefix(trie, prefix_seq) do
    case walk_down(prefix_seq, trie) do
      nil -> []
      subtrie -> flatten_with_prefix(prefix_seq, subtrie)
    end
  end

  def map(trie, func) do
    to_list(trie)
    |> Enum.map(func)
    |> from_list()
  end

  def merge(trie1, trie2) do
    from_list(to_list(trie1) ++ to_list(trie2))
  end

  def remove_prefix(trie, prefix_seq) do
    case walk_down(prefix_seq, trie) do
      nil -> trie
      _ -> remove_prefix_path(prefix_seq, trie)
    end
  end

  def size(trie), do: length(to_list(trie))

  # ========== Internal Helpers ==========

  defp walk_down([], trie), do: trie

  defp walk_down([h | t], trie) do
    case Map.get(trie, h) do
      nil -> nil
      subtrie -> walk_down(t, subtrie)
    end
  end

  defp remove_prefix_path([], _trie), do: %{}

  defp remove_prefix_path([h | t], trie) do
    case Map.get(trie, h) do
      nil -> trie
      subtrie ->
        updated = remove_prefix_path(t, subtrie)
        if map_size(updated) == 0 do
          Map.delete(trie, h)
        else
          Map.put(trie, h, updated)
        end
    end
  end

  defp flatten_with_prefix(prefix, trie) do
    base =
      if Map.has_key?(trie, @end_marker) do
        [prefix]
      else
        []
      end

    children =
      trie
      |> Enum.reject(fn {k, _} -> k == @end_marker end)
      |> Enum.flat_map(fn {k, sub} -> flatten_with_prefix(prefix ++ [k], sub) end)

    base ++ children
  end
end
