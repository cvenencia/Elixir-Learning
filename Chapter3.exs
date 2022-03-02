IO.puts("This is not" <> " just one string")

IO.puts("1 is not strictly equal to 1.0 (different data types)")
IO.puts(1 === 1.0)

IO.puts("'and', 'or' and 'not' operators expect only boolean values")
IO.puts(true and false)

IO.puts("||, && and !, on the other hand, accept any data types")
IO.puts(1 || false)

IO.puts("There is a hierarchy to which data type is greater than another one.")
IO.puts(1 < :an_atom)