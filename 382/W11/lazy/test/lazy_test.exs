defmodule LazyTest do
  use ExUnit.Case

  test "generates 5 random numbers in range" do
    min = 10
    max = 20
    stream = Lazy.start_stream(min, max)

    numbers =
      for _ <- 1..5 do
        send(stream, {:get, self()})

        receive do
          {:random_number, num} ->
            assert num >= min and num <= max
            num
        after
          1000 -> flunk("No response from stream")
        end
      end

    assert length(numbers) == 5

    send(stream, :stop)
  end
end
