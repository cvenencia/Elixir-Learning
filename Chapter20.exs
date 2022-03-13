# Types and specs

# Elixir is a dynamically typed language, so all types in Elixir are checked at runtime.
# Nonetheless, Elixir comes with typespecs, which are a notation used for:
# 1. Declaring typed function signatures
# 2. Declaring custom types.


# Functions specifications

# Specs describe both public and private functions. The function name and the
# number of attributes in the @spec must match the function it describes.
# Note this is just for documentation purposes. This is not used by the compiler in
# any way, and so nothing would happen if the spec for the function doesn't match
# what it returns.

defmodule TestModule do
	# Notice how the spec says integer, but there is no consequence when the
	# function returns a boolean
	@spec is_greeting(String.t()) :: integer()
	def is_greeting(string) when string == "hello", do: true
	def is_greeting(_), do: false
end

IO.puts(TestModule.is_greeting("hello"))
IO.puts(TestModule.is_greeting("helloo"))


# Defining custom types

# By defining a custom type, we can communicate better the intention of our code
# and increase its readability. Custom types can be defined within modules with the
# @type attribute. Also, we can create private types with @typep.

# We can document the types we create with the attribute @typedoc

defmodule Person do
	@typedoc """
	The type of the ID (CC, TI or NIT)
	Examples: :cc, :ti, :nit
	"""
	@type id_type :: atom()

	@typedoc """
	The numeric part of the ID
	"""
	@type id_number :: number

	@typedoc """
	A map that represents a colombian ID
	"""
	@type id :: %{id_type: id_type, id_number: id_number}

	@doc """
	Receives a string representation of an ID
	Returns a @type id

	## Examples
		iex> id_number("C.C.1125458769")
		%{id_type: :cc, id_number: 1125458769}
	"""
	@spec parse_id(id) :: id
	def parse_id(id) do
		r_number = ~r/(\d{7,10})/
		r_type = ~r/(CC|TI|NIT)/
		[_, type] = Regex.run(r_type, id)
		[_, number] = Regex.run(r_number, id)
		%{id_type: atom_type(type), id_number: number}
	end

	defp atom_type(type) when type == "CC", do: :cc
	defp atom_type(type) when type == "TI", do: :ti
	defp atom_type(type) when type == "NIT", do: :nit
end

IO.inspect(Person.parse_id("CC1125458769"))
IO.inspect(Person.parse_id("NIT901458758"))

# Static code analysis

# Tools like Dialyzer use typespecs in order to perform static analysis of code.
# That is why it is useful to write a spec for private functions, even though
# that documentation won't be useful to developers.


# Behaviours

# They provide a way to:
# 1. Define a set of functions that have to be implemented by a module.
# 2. Ensure that a module implements all the functions in that set.

# Behaviours are similar to interfaces in object oriented languages.

# Defining behaviours

# Modules adopting a behaviour will have to implement all the functions defined with
# the @callback attribute. @callback expects a function name and the specification
# for that function.

defmodule Parser do
	@doc """
	Parses a string.
	"""
	@callback parse(String.t()) :: {:ok, term} | {:error, String.t()}

	@doc """
	Lists all supported file extensions
	"""
	@callback extensions() :: [String.t()]

	def parse!(implementation, contents) do
    case implementation.parse(contents) do
      {:ok, data} -> data
      {:error, error} -> raise ArgumentError, "parsing error: #{error}"
    end
  end
end

defmodule JSONParser do
	@behaviour Parser

	@type json :: String.t

	@impl Parser
	@spec parse(String.t) :: {:ok, json}
	def parse(str) when str == "hello", do: {:ok, "The parsed JSON: " <> str}
	def parse(_), do: {:error, "Not a JSON file"}

	@impl Parser
	def extensions(), do: ["json"]
end

IO.inspect(Parser.parse!(JSONParser, "hello"))
