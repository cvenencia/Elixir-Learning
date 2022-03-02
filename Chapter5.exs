tuple = {1, 2, 3}
case tuple do
	{"d", "e", "f"} ->
		IO.puts("Does not match")
	{x,y,z} when x < y and z > y ->
		IO.puts("Matches")
	_ ->
		IO.puts("Nothing matches")
end

IO.puts("If an error occurs while testing a match, it will simply fail and move on, instead of stopping the program:")
case tuple do
	{"d", "e", "f"} ->
		IO.puts("Does not match")
	{x,_,_} when hd(x) ->
		IO.puts("hd(x) will throw and error")
	_ ->
		IO.puts("Nothing matches")
end

IO.puts("\nAnonymous functions with clauses")
f = fn
	x, y when y != 0 -> x / y
	_x, _y -> :error
end

IO.puts(f.(1,2))
IO.puts(f.(1,0))

IO.puts("\ncond: equivalent to else-if in many languages")

cond do
	false ->
		IO.puts("This will never print")
	f.(4,2) < 4 ->
		IO.puts("4/2 = 2 < 4. This will print")
	true ->
		IO.puts("There should be a true condition if none of the above are true, if not an error is raised. Since the condition above was true, this will never print")
end

IO.puts("\nif, else and unless:")

if nil || false do
	IO.puts("This will never print")
else
	IO.puts("Any value different to nil and false will evaluate to true")
end

unless nil do
	IO.puts("'unless x' is like 'if not x'")
end

IO.puts("\nVariable scope:")
x = 1 # x starts at 1
if true do
	x = 4 # x changes to 4, but only in the scope of the 'if'
	IO.puts("Inside if: x = #{x}")
end
IO.puts("After if: x = #{x}")

# The correct way:
x = if true do
	4
end
IO.puts("x = #{x}")