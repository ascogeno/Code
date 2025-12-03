# Using Elixir Streams, write a pipeline that:

# Reads a large log file lazily (assume it has thousands of lines formatted like INFO:msg or ERROR:msg).
# Filters the stream so only "ERROR" lines remain.
# Strips off the "ERROR:" prefix lazily.
# Counts how many error messages there are without ever loading all lines into memory.
# Returns the final count.

# Requirements (to test your competency)
# You must use Stream for the transformations.
# You must not materialize intermediate collections.
# You must explain what triggers final execution.
# Keep the solution to a brief code snippet plus a 1–2 sentence explanation.

defmodule Streams do
  @moduledoc """
  Demonstrates a lazy streaming pipeline that reads a large log file,
  filters ERROR lines, strips prefixes, and counts them without
  ever loading the entire file into memory.
  """

  def count_errors(path) do
    path
    # lazy line-by-line producer
    |> File.stream!()
    |> Stream.filter(&String.starts_with?(&1, "ERROR:"))
    |> Stream.map(&String.replace_prefix(&1, "ERROR:", ""))
    # triggers final execution
    |> Enum.count()
  end
end
