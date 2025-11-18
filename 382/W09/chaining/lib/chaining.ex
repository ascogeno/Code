defmodule Chaining do
  # The chaining function: takes input data and a list of functions to apply
  def chain(data, []), do: data
  def chain(data, [func | rest]), do: chain(func.(data), rest)

  # Step 1: convert file paths into file names
  def get_file_names(paths) do
    Enum.map(paths, &Path.basename/1)
  end

  # Step 2: sort file names by file extension
  def sort_by_extension(file_names) do
    Enum.sort_by(file_names, &Path.extname/1)
  end

  # Step 3: remove duplicates
  def remove_duplicates(file_names) do
    Enum.uniq(file_names)
  end

  # Convenience function to run the whole chain
  def run(paths) do
    chain(paths, [
      &get_file_names/1,
      &sort_by_extension/1,
      &remove_duplicates/1
    ])
  end
end
