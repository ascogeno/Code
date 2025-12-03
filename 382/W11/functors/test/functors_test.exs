# had AI cook this up. worked on this before thanksgiving, but turning it in now that im back in town

defmodule FunctorsTest do
  use ExUnit.Case
  alias Functors

  describe "Functor map/2" do
    test "applies function to success value" do
      assert Functors.map({:ok, 10}, fn x -> x * 2 end) == {:ok, 20}
    end

    test "leaves error value untouched" do
      assert Functors.map({:error, "fail"}, fn _ -> raise "should not be called" end) ==
               {:error, "fail"}
    end

    test "identity law holds" do
      identity = fn x -> x end
      assert Functors.map({:ok, 42}, identity) == {:ok, 42}
      assert Functors.map({:error, "nope"}, identity) == {:error, "nope"}
    end

    test "composition law holds" do
      f = fn x -> x + 1 end
      g = fn x -> x * 2 end
      composed = fn x -> g.(f.(x)) end

      result = {:ok, 3}

      # Applying f then g through map
      step_by_step = Functors.map(Functors.map(result, f), g)
      # Applying the composed function directly
      composed_applied = Functors.map(result, composed)

      assert step_by_step == composed_applied
    end
  end
end
