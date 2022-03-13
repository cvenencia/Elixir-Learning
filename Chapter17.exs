# Comprehensions

# It is common to loop over an Enumerable, filtering out some elements,
# and mapping some others. A comprehension is ideal for this type of constructs.
# A comprehension consists of three parts: generators, filters and collectables.

list = for n <- [1,2,3,4], do: n*n*n
IO.inspect(list)

# On this example, 'n <- [1,2,3,4]' is the generator. It generates the values
# used in the comprehension.
# Comprehensions also support pattern matching. If a pattern doesn't match,
# that value will simply be ignored.

list = for {:good, n} <- [good: 0, bad: 1, bad: 2, bad: 3, good: 4], do: n
IO.inspect(list)

# Alternatively to pattern matching, we can use filters to ignore some elements:

list = for n <- 0..10, rem(n, 2) == 0, do: n*n
IO.inspect(list)

# Finally, we can combine all of this methods all we need.

list = for {:good, n} <- [good: 0, bad: 1, bad: 2, good: 4],
	rem(n, 2) == 0, do: n*n
IO.inspect(list)

# We can even use multiple generators to calculate the cartesian product of two lists:

result = for i <- [:a, :b, :c], j <- [1, 2], do: {i, j}

IO.inspect(result)


# Bitstring generators

# They are useful when we need to comprehend over bitstrings streams.
# For example, we have a stream of bits representing pixels, with their respective
# red, green and blue values. We can comprehend this stream and convert it into a
# list of tuples, each containing the RGB values:

pixels = <<0,0,0,255,0,255,255,0,0,255,255,255>>

tuple = for <<r::8, g::8, b::8 <- pixels>>, do: {r,g,b}

IO.inspect(tuple)


# :into option

# Up to this point, all comprehensions returned a list as their result. However, it is
# possible to insert the result of a comprehension to other data structures with
# the :into option

no_spaces = for <<c <- "          hello world ">>, c != ?\s, into: "", do: <<c>>
IO.puts(no_spaces)

transformed_map = for {key, value} <- %{a: 2, b: 20}, into: %{}, do: {key, value * value}
IO.inspect(transformed_map)
