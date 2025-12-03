# In your editor, create a monoid for boolean values with logical OR as the operation. Identify the identity element.

defmodule Monoidos.BooleanOrMonoid do
  @moduledoc """
  A monoid implementation for boolean values using logical OR as the operation.
  """

  @type t :: boolean()

  @doc """
  Returns the identity element for the Boolean OR monoid.

  In this monoid, the identity element is `false`.
  """
  @spec identity() :: t()
  def identity, do: false

  @doc """
  Applies the binary operation (logical OR) to two boolean values.

  This operation satisfies all monoid laws:
    - binary (two parameters)
    - closed over booleans
    - associative
    - has an identity element (`false`)
    - same input/output type (boolean)
  """
  @spec combine(t(), t()) :: t()
  def combine(a, b) when is_boolean(a) and is_boolean(b), do: a || b
end
