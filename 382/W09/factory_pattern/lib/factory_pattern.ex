# In your editor, write a factory function that creates a circular list (a list where the last element points back to the first). Test it with a list of size 3.

defmodule FactoryPattern do
  defmodule Node do
    defstruct [:value, :next]
  end

  def create_circular_list(size) when is_integer(size) and size > 0 do
    1..size
    |> Enum.reverse()
    |> Enum.reduce(nil, fn v, acc ->
      %Node{value: v, next: acc}
    end)
  end
end
