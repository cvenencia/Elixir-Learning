# 'alias', 'require' and 'import' are lexically scoped, meaning they are only usable
# in the scope they were defined in.


# Aliases

# Allow us to set up a custom name for a module

alias Enum, as: Custom

IO.inspect(Custom.map(1..20, fn x -> x*3 end))

# If alias is called without 'as:', it will set up the alias to the last part of the module name:

fun = fn -> alias Math.List end
fun.()

# This is equivalent to:

fun = fn -> 
	alias Math.List, as: List
	IO.puts(List)
end
fun.()

# Aliases are converted to atoms during compilation. In the example above, the alias
# 'List' is converted to the atom ':Elixir.Math.List'


# Require

# Elixir provides macros as a mechanism for meta-programming
# In order to use macros, we have to 'require' the module that contains it

fun = fn -> 
	require Integer
	IO.puts(Integer.is_odd(3))
end
fun.()

# Macros will be explained in detail in a future chapter.


# Import

# 'import' allows us to access functions and macros defined in other modules, without having
# to use the fully-qualified name.

fun = fn -> 
	import List
	x = duplicate(0, 4) # Function from List
	IO.inspect(x)
end
fun.()

# Instead of having to write 'x = List.duplicate(10, 4)'

# Import also allows to only import specific functions. With this, we avoid to import
# unnecessary functions to our program.

fun = fn -> 
	import List, only: [duplicate: 2] # Import only the function 'duplicate/2'
	x = duplicate(0, 4) 
	IO.inspect(x)
end
fun.()

# 'import' is normally recommended to not be used. Prefer to use 'alias' to import,
# or 'require' to import macros.


# Use

# This is used as an extension point. This means that when you use a module, it runs
# a function called '__using__' within the module.
# This way, a module can inject code into the current module.


# Module nesting

# It is possible to have nested modules, like so:

defmodule Foo do
	defmodule Bar do
	end
	defmodule Baz do
	end
	# 'Bar' can be accesed by just 'Bar'.
end

# As modules are independent to one another, it is possible to define the 'Bar' module
# before the 'Foo' module is defined.

defmodule Foo.Bar do
end

defmodule Foo do
	alias Foo.Bar
	# 'Bar' can be accesed by just 'Bar'
end


# alias/import/require/use multiple modules at once

# When modules are nested into a big module, it is possible to include them all in on line:

# alias Foo.{Bar, Baz}
