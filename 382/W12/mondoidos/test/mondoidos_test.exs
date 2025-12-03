defmodule Monoidos.BooleanOrMonoidTest do
  use ExUnit.Case, async: true

  alias Monoidos.BooleanOrMonoid

  describe "Monoid laws" do
    test "identity element does not change values" do
      assert BooleanOrMonoid.combine(true, BooleanOrMonoid.identity()) == true
      assert BooleanOrMonoid.combine(false, BooleanOrMonoid.identity()) == false
      assert BooleanOrMonoid.combine(BooleanOrMonoid.identity(), true) == true
      assert BooleanOrMonoid.combine(BooleanOrMonoid.identity(), false) == false
    end

    test "operation is associative" do
      a = true
      b = false
      c = true

      left = BooleanOrMonoid.combine(BooleanOrMonoid.combine(a, b), c)
      right = BooleanOrMonoid.combine(a, BooleanOrMonoid.combine(b, c))

      assert left == right
    end

    test "operation is closed and returns a boolean" do
      assert is_boolean(BooleanOrMonoid.combine(true, false))
      assert is_boolean(BooleanOrMonoid.combine(false, false))
      assert is_boolean(BooleanOrMonoid.combine(true, true))
    end
  end
end
