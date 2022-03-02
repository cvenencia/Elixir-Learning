x = 10               
10 = x # Valid match 
# 20 = x -> MatchError

[a, b, c] = [:hello, "world", 50]

IO.puts("#{a}, #{b}, #{c}")
IO.puts("Both sides of the match operator (=) must be equal in size, and must be of the same type.")

[head | tail] = ["a", "b", "c", "d"] # Get the head and tail of the list
IO.puts("head = #{head}, tail = #{tail}")

list = [tail | "z"]
IO.puts("Append or prepend elements to a list: [tail | \"z\"] = #{list}\n")

IO.puts("It is possible to pin the value of a variable to make it behave as a constant:")
x = 1
[^x,2,3] = [1,2,3] # Valid match. Equivalent to [1,2,3] = [1,2,3]
# [^x,2,3] = [2,3,1] Invalid match. Equivalent to [1,2,3] = [2,3,1]

IO.puts("When matching, if a value is not needed, it can be assigned to _")
[_ | tail] = [1,2,3,4]
IO.puts("#{tail}")


