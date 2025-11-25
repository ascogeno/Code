# In your editor, implement a memoized function to calculate shipping costs based on weight and distance.

defmodule Memoization do
  use GenServer

  ## --- Client API ---

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def get_or_compute(fun, args) when is_function(fun, length(args)) do
    GenServer.call(__MODULE__, {:request, fun, args})
  end

  def cost(weight, distance) do
    base = 5
    weight_rate = 0.8
    distance_rate = 0.05
    base + weight * weight_rate + distance * distance_rate
  end

  ## --- Server Callbacks ---

  @impl true
  def init(state), do: {:ok, state}

  @impl true
  def handle_call({:request, fun, args}, _from, cache) do
    key = {fun, args}

    case Map.fetch(cache, key) do
      {:ok, result} ->
        {:reply, result, cache}

      :error ->
        result = apply(fun, args)
        {:reply, result, Map.put(cache, key, result)}
    end
  end
end
