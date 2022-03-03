# There are two ways of compiling Elixir code
# One is with the command 'elixir filename.exs'. This way it compiles,
# loads in memory and executes.
# The other way is with the command 'elixirc filename.ex'. It does the samething
# as the command above, except it also creates a local file containing the bytecode
# of the module inside the script.

# After compiling and creating the local file, this module is now accesible to all other scripts
# in the same directory, no need to import.

# Functions can be defined in two ways:
# Normally with the keyword 'def'
# Or privately with the keyword 'defp'. This way, the function can only be called within the module.

# Functions also support guards and multiple clauses.
# If an argument does not match any clauses, an error will be raised


defmodule Square do
	
	def area(side) do
		side*side
	end
	
	def perimeter(side) do
		side*4
	end
	
	def real_square?(side) when side <= 0 do
		false
	end
	
	def real_square?(side) when side > 0 do
		true
	end
	
end

IO.puts(Square.area(3))
IO.puts(Square.perimeter(3))
IO.puts(Square.real_square?(3))
IO.puts(Square.real_square?(0))


# Function capturing
# By ussing the capture operator (&), we can assigned a named function to a variable
# and to use them like anonymous functions

captured_function = &Square.area/1
captured_function2 = &+/2

IO.puts(captured_function.(20))
IO.puts(captured_function2.(10, 45))

# This notation can also be used to create functions
# &1, &2... are used to refer to the arguments of the function

short_function = &(&1 + &2)
IO.puts(short_function.(10,20))

# Default arguments
# If a function has multiple clauses, a function head must be created

defmodule MyModule do

	def join(a, b \\ nil, sep \\ " ")
	
	def join(a, b, _sep) when is_nil(b) do
		a
	end
	
	def join(a, b, sep) do
		a <> sep <> b
	end
	
	
end

IO.puts(MyModule.join("c", "t"))
IO.puts(MyModule.join("c"))
IO.puts(MyModule.join("c", "t", "a"))
