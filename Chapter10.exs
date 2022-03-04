# Enumerables

# The 'enum' module provides conveniences for working with lists.

# These are the ways of writing the examples in chapter 9 with enum:

list = [10, 2, 45]

# Sum all elements in the list
sum = Enum.reduce(list, fn(elem, acc) -> elem + acc end)
IO.puts(sum)

# Map the parity of each element of the list
parity_list = Enum.map(list, fn elem -> rem(elem, 2) == 0 end)
IO.inspect(parity_list)

# Elixir also provides ranges:

IO.inspect(Enum.map(1..10, fn x -> x*x end))

# When performing multiple operations with Enum, each step will generate an intermediate list,
# until the result is reached. This means that Enum is EAGER

# The pipe operator (|>)
# It is similar in function to the pipe operator in Unix. It allows to see more clearly
# the pipeline in which the data is flowing

# The result of one stage is sent to the next stage as the first parameter of the function call

# Here we get numbers 1 to 100.000, then we square each number, then we take only the odd ones, and then we sum them
# Very clear data flow
result = 1..100000 |> Enum.map(&(&1 * &1)) |> Enum.filter(&(rem(&1, 2) == 1)) |> Enum.sum()
IO.puts(result)


# Streams

# Streams are an alternative to Enum. It supports LAZY operations.
# Meaning, instead of generating intermediate lists, streams build a series of 
# computations that are invoked only when we pass the underlying stream to the Enum module.
# This is advantageous specially when dealing with huge (or maybe infinite) datasets, or with
# slow resources like network resources.

# I won't focus much with streams for the moment, since I won't be working with huge datasets.
# First, I will focus on Enum and if the need comes, I will try out Streams.
