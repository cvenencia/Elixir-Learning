# Recursion

# Since data structures in Elixir are immutable, it relies on recursion

defmodule Recursion do
	
	# Function to count to n
	def count_to(n, i \\ 0)
	
	def count_to(n, i) when i < n do
		IO.puts(i)
		count_to(n, i+1)
	end
	
	def count_to(n, i) when i == n do
		:ok
	end
	
	
	# The process of reducing a list down to one value is called a 'reduce algorithm'
	
	# Function to sum all elements in a list and count the elements in the list
	def sum_list(_, accumulator \\ 0, counter \\ 0)
	
	def sum_list([head | tail], accumulator, counter) do 
		sum_list(tail, accumulator + head, counter + 1)
	end
	
	def sum_list([], accumulator, counter) do
		{accumulator, counter}
	end
	
	# Function to calculate the average of a list
	def avg_list(list) do
		{accumulator, counter} = sum_list(list)
		accumulator / counter
	end
	
	
	# The process of taking a list and mapping over it is known as a 'map algorithm'
	
	# Function that maps each element with its parity
	def parity_list([head | tail]) do
		[rem(head, 2) == 0 | parity_list(tail)]
	end
	
	def parity_list([]) do
		[]
	end
	
end



Recursion.count_to(5)
IO.puts("")
Recursion.count_to(5, -2)

IO.puts("")
list = [10,2,45]
IO.puts(elem(Recursion.sum_list(list), 0))
IO.puts(Recursion.avg_list(list))

IO.puts("")

# IO.inspect allows to print a list visually
IO.inspect(Recursion.parity_list(list))
