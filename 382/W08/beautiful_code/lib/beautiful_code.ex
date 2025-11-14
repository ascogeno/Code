# In your editor, write a pipeline function that filters even numbers, squares them, and sums them from a list. Ensure the pipeline is beautifully readable.
# Also, the below documentation was suggested by Chat, and I was going to delete it cause I think it looks weird,
# but remembered the pattern I'm trying to emulate so I'm keeping it

defmodule BeautifulCode do
  @moduledoc """
  Provides utilities for transforming and analyzing lists of numbers
  using readable, composable, and testable pipelines.
  """

  @doc """
  Filters even numbers from the list, squares them, and returns the sum.

  ## Examples

      iex> BeautifulCode.sum_of_even_squares([1, 2, 3, 4])
      20

  """
  def sum_of_even_squares(numbers) do
    numbers
    |> Enum.filter(&even?/1)
    |> Enum.map(&square/1)
    |> Enum.sum()
  end

  defp even?(n), do: rem(n, 2) == 0

  defp square(n), do: n * n
end
