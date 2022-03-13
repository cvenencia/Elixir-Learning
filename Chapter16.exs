# Protocols

# Protocols are a mechanism to achieve polymorphism. It provides an easy way to
# extend the functionality for as long as we need. For example:

# defmodule Utility do
#	def type(value) when is_binary(value), do: "string"
#	def type(value) when is_integer(value), do: "integer"
# end

# In the case we need to add more types to check on this module, and
# we did not have access to this module, it would be impossible to
# extend it for more data types. Instead, we create a protocol.

defprotocol Utility do
	@spec type(t) :: String.t()
	def type(value)
end

defimpl Utility, for: Bitstring do
	def type(_value), do: "string"
end

defimpl Utility, for: Integer do
	def type(_value), do: "integer"
end

# This way, we don't need to constantly modify the module every time we
# need to add a new type. Even better, when we do not have access to modify
# the module.

# Implementing a protocol for size (Chapter16_Structs.exs)

IO.puts(Size.size("Hello world"))
IO.puts(Size.size({1,2,3,4,:ok,:error}))
IO.puts(Size.size(%{name: "John", description: "A nice person!"}))


# Protocols and structs

# The power of protocols comes when combined with structs. In chapter 15, we
# learned that even though structs are maps, they do not share protocol
# implementations with maps. Structs require their own protocol implementation.
# Mapsets (sets based on maps) have their size precomputed, so we can
# implement the size protocol with them:

defimpl Size, for: MapSet do
	def size(set), do: MapSet.size(set)
end

# This way, we could implement relevant protocols, such as Enumerable, for
# a struct that we have defined.

# We can define a default implementation of a protocol for Any data type. (Chapter16_Structs.exs)

# Even though this implementation may not be useful for any data type,
# if you fell like this implementation would work with your struct,
# you can derive the protocol (Chapter16_Structs.exs):

other_user = %OtherUser{name: "John", age: 30}
IO.puts(Size.size(other_user))

# It can be set that a protocol would fallback to Any if no implementation
# is found, with the attribute @fallback_to_any set to 'true'
# This way, any struct or data type that has no implementation of the
# protocol, will fallback to the implementation of Any, no matter if the
# struct is derived from Any.


# Built-in protocols

# For example, the Enum module provides many functions that work with
# all data types that implement the 'Enumerable' protocol.
# Another example is the 'String.Chars' protocol. This is what is used to
# convert a complex data structure into readable representations as a string,
# via the 'to_string' function.
# This is what allows the following:

IO.puts("Numbers implement the 'String.Chars' protocol: #{150}")

# Tuples and lists, for example, don't implement the 'String.Chars' protocol.
# They instead implement the 'Inspect' protocol:

IO.puts("Inspecting: #{inspect [1,2,3]}")
