# In your editor, create a functor for a Result type (representing success or error). Ensure the lambda applies only to the success case.

defmodule Functors do
  @moduledoc """
  A functor implementation for the Result type.
  """

  @type result(a, b) :: {:ok, a} | {:error, b}

  @doc """
  Applies the given function to the success value of a Result.
  The structure is preserved. Errors are passed through unchanged.

  ## Examples

      iex> Functors.map({:ok, 5}, fn x -> x + 1 end)
      {:ok, 6}

      iex> Functors.map({:error, "fail"}, fn x -> x + 1 end)
      {:error, "fail"}
  """
  @spec map(result(a, b), (a -> c)) :: result(c, b) when a: any, b: any, c: any
  def map({:ok, value}, func) when is_function(func, 1) do
    {:ok, func.(value)}
  end

  def map({:error, reason}, _func) do
    {:error, reason}
  end
end
