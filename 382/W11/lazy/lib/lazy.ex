# Write a lazy function that generates an infinite stream of random numbers within a given range. Test it by fetching 5 random numbers, one at a time.

# Please test your code to see if it works.

defmodule Lazy do
  def start_stream(min, max) do
    spawn(fn -> loop(min, max) end)
  end

  defp loop(min, max) do
    receive do
      {:get, requester} ->
        number = :rand.uniform(max - min + 1) + min - 1
        send(requester, {:random_number, number})
        loop(min, max)

      :stop ->
        :ok
    end
  end
end
