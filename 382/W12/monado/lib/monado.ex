# In your editor, implement a monad that tracks a log along with computations. Define the unit and bind functions for it.

defmodule Monado do
  @moduledoc """
  A Writer Monad that tracks a log alongside computation results.
  """

  @type log :: [String.t()]
  @type value :: any()
  @type monad :: {value, log}

  @doc """
  Wraps a raw value in the monadic structure with an empty log.
  """
  @spec unit(value) :: monad
  def unit(val), do: {val, []}

  @doc """
  Binds a monadic value to a function that returns a new monadic value,
  combining logs along the way.
  """
  @spec bind(monad, (value -> monad)) :: monad
  def bind({val, log1}, func) do
    {new_val, log2} = func.(val)
    {new_val, log1 ++ log2}
  end
end
