ExUnit.start()

defmodule ChainingTest do
  use ExUnit.Case
  alias Chaining

  test "file paths are converted, sorted by extension, and deduplicated" do
    input = [
      "/some/path/to/file1.txt",
      "/some/other/path/file2.ex",
      # duplicate
      "/some/path/to/file1.txt",
      "/another/path/file3.md",
      "/yet/another/file4.ex"
    ]

    result = Chaining.run(input)

    expected = [
      "file2.ex",
      "file4.ex",
      "file3.md",
      "file1.txt"
    ]

    assert result == expected
  end
end
