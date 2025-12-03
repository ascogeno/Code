defmodule ETS do
  @table :counter_table

  # Creates the table synchronously so it's guaranteed to exist
  def start_link do
    pid =
      spawn_link(fn ->
        :ets.new(@table, [:set, :public, :named_table])
        Process.sleep(:infinity)
      end)

    # Wait until the table exists before returning
    wait_for_table(@table)

    {:ok, pid}
  end

  defp wait_for_table(table) do
    unless :ets.whereis(table) != :undefined do
      Process.sleep(1)
      wait_for_table(table)
    end
  end

  def increment(key) do
    :ets.update_counter(@table, key, {2, 1}, {key, 0})
  end

  def get(key) do
    case :ets.lookup(@table, key) do
      [{^key, value}] -> value
      _ -> 0
    end
  end
end
