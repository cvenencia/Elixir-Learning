IO.puts("Anonymous functions: multiplication of two numbers")
mult = fn a,b -> a * b end

IO.puts(mult.(2,4))
IO.puts(is_function(mult))

IO.puts("Using a variable in the same scope as another anonymous function: squaring a number")
squared = fn a -> mult.(a, a) end

IO.puts(squared.(8))

# lists and tuples

list = [1, 2, 3, 4, 5, 6]
tuple = {1, 2, 3, 4, 5, 6}

IO.puts("Lists are handled as linked lists. On the other hand, tuples are handled as regular arrays, meaning the elements are in a contiguous spaces in memory")

list = list ++ [7] # This is ideal. Not expensive
tuple = put_elem(tuple, 5, 7) # This is not ideal. Very expensive. Has to create a new identical tuple

IO.puts(tuple_size(tuple)) # Not expensive. Accesing the tuple size is fast
IO.puts(length(list)) # Very expensive. To get the size of the list, it is necessary to traverse the whole list
