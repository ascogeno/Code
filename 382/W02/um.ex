# Variables
##In your editor, assign the result of a multiplication operation to a variable and add a constant to it in another variable.
preresult = 7 * 6

result = preresult + 10

IO.puts("Preresult: #{preresult}")
IO.puts("Postresult: #{result}")


# Tuples
##In your editor, assign a tuple representing a person’s location ({City, Country}) and extract the city name.
location = {"Paris", "France"}

{city, _country} = location
IO.puts("Extracted City: #{city}")



# Lists
##In your editor, use pattern matching to retrieve the last element of a list by reversing it first.
list = [1, 2, 3, 4, 5]

[last_element | _rest] = Enum.reverse(list)
IO.puts("Last element but its a lie cause i reversed the list so really this is the first item: #{last_element}")



# List BIFs (Built-In Functions from Enum)
##In your editor, apply Enum.at/2 to retrieve the third element in a list.
third = Enum.at(list, 2)
IO.puts("Third: #{third}")
