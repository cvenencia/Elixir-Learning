IO.puts("There is a difference between double-quoted and single-quoted strings, but first: Unicode and code points")

IO.puts("Unicode is a standard that defines what a combination of binary, 
digits translates to, no matter where you are. For example, 0x61 = 97, 
and that is the code point of 'a'. In elixir, we can get the code point 
of a character by using '?' in front of it")

IO.puts("#{0x61 === ?a}")

IO.puts("Not all Unicode characters take up 1 byte of memory. Also, some characters take up more than one code point")
string = "héllo"
IO.puts("#{String.length(string)}")
IO.puts("#{length(String.to_charlist(string))}")
IO.puts("#{byte_size(string)}")

IO.puts("#{IO.inspect(string, binaries: :as_binaries)}")

IO.puts("\nBitstrings: are a contiguous sequence of bits in memory. By default, each number in a bitstring is its 8-bit representation")
IO.puts(<<2::2>> == <<1::1, 0::1>>)

IO.puts("\nDifference between binaries and bitstrings: a binary is a bitstring where the number of bits is divisible by 8")
IO.puts("Matching binaries: works the same way as before. By default, a variable would match an 8-bit word, unless specified otherwise. If the size is unknown, we can use the 'binary' modifier. If what we want to match is a character, we can use the 'utf8' modifier, since strings are binaries.")
<<x::binary>> = <<346::16>>

IO.puts("\nCharlists: is a list of integers where all of them are valid code points. These are created when typing a string with single quotes.")
IO.puts("By default, when displaying a charlist, the interpreter will show them as the corresponding ASCII characters.")
amounts = [104, 101, 108, 108, 111]
IO.puts("Amounts = #{amounts}")



 

