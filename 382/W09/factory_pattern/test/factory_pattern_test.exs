defmodule FactoryPatternTest do
  use ExUnit.Case
  alias FactoryPattern.Node

  test "create list of size 3" do
    list = FactoryPattern.create_circular_list(3)

    assert %Node{value: 1} = list
    assert %Node{value: 2} = list.next
    assert %Node{value: 3} = list.next.next
    assert list.next.next.next == nil
  end
end
