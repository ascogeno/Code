defmodule StreamsTest do
  use ExUnit.Case
  doctest Streams

  test "counts only ERROR lines lazily" do
    # Create a temporary test file
    path = Path.join(System.tmp_dir!(), "test_logs.log")

    File.write!(path, """
    INFO:boot complete
    ERROR:could not connect
    INFO:retrying
    ERROR:timeout reached
    ERROR:data corrupted
    """)

    assert Streams.count_errors(path) == 3
  end
end
