#In your editor, create a stateless process that computes the factorial of a given number.
defmodule Math do
  def factorial(0), do: 1
  def factorial(n) when n > 0 do
    n * factorial (n-1)
  end
end

IO.puts("Factorial of 5 is: #{Math.factorial(5)}")
