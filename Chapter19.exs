# try, catch and rescue

# Elixir has three mechanisms: errors, throws and exits.


# Errors

# Errors or exceptions are used when something goes wrong in the program.
# For example, when we try to make an arithmetic operation between two incompatible
# operands (atoms and numbers, strings and numbers).
# A Runtime error can be raised just with the keyword 'raise' and a message.
# Other errors can be raised with raise/2 passing the error name and a keyword list.

# We can also define our own errors by creating a module and using 'defexception' inside.

defmodule MyError do
	defexception message: "My custom error message"
end

# raise MyError

# Errors can be rescued using the try/rescue construct:

x = try do
	2 + ""
	raise MyError
rescue
	MyError -> "Something went wrong"
	a in ArithmeticError -> a.message
end

IO.puts(x)

# In practice, this construct is rarely used. In Elixir, there is a convention that a function
# returned a tuple of this structure {:ok, result} if everything went well. And if there was an
# error, it should return {:error, reason}. This is so it is easier to pattern match when calling
# a function and to decide what to do in each case.
# However, if an error is truly expected to be raised if something goes wrong, there should
# exist a function with the same name, with '!' at the end. If that function is called and
# something goes wrong, that function will raise an error.

# Errors should't be used for controlling the flow of the code. In Elixir, errors are taken
# literally: they are reserved for unexpected, diruptive and/or exceptional situations.

# A great example of this are the functions of the module File for reading files.
# 'File.read/1' will return a tuple with the structure mentioned before, but 'File.read!/1'
# will return only the result (not enclosed in a tuple) or raise an error if the file doesn't
# exist.

# Now, it is up to the developer to decide which option is better suited for their program.


# Reraise

# Even though in the previous section it was established that try/rescue constructs are rarely
# used, a good reason to use it is for monitoring/observability. If we wanted to log that
# something went wrong, you could do:

try do
	raise MyError
rescue
	_e ->
		# Some code to log the error
		# reraise e, __STACKTRACE__
end

# Throws

# In elixir, a value can be thrown and later be caught. 'throw' and 'catch' are reserved
# for situations where it is impossible to retrieve a value unless by using them.
# Those situations are quite uncommon in practice. Here is an example:

# Trying to find the first prime number in a range using Enum

result = try do
	Enum.each(-50..50, fn x ->
		if rem(x, 60) == 0, do: throw x
	end)
	"Nothing"
catch
	x -> "Got #{x}"
end

IO.puts(result)

# But Enum provides a proper API to achieve something like this, so this is the way to go:

result = Enum.find(-50..50, fn x -> rem(x, 13) == 0 end)
IO.puts(result)


# Exits

# Al elixir code runs inside processes that communicate with each other. When a process dies,
# it sends an exit signal. Exit signals can also be caught by using try/catch.
# Using try/catch is alredy uncommon, and using it to catch exits is even rarer.

# Exit signals are a vital part of the fault tolerant system provided by the Erlan VM. 
# Processes usually run under supervision tress, which are themselves processes that listen
# to exit signals from the supervises processes. This way, instead of trying to fix an error,
# the system will 'fail fast' and the supervision tree will guarantee the application will go
# back to a known initial state after the error.


# After

# The after clause will ensure that regardless of an error raising or not, what is in the
# after block, will run. This is useful, for example, when opening a file and something goes
# wrong. In the after block, we can ensure that the file will be closed regardless of the 
# error that may have occured.

# However, this is not a guarantee that if an error occurs, this block would be executed.
# If a linked process exits, this process will exit too and the after clause will not get
# executed.

# Sometimes it would be desired to wrap the entire body of a function inside a
# try/(after|catch|rescue). In this case, you can omit the 'try' line.

defmodule RunAfter do
	def without_try do
		raise "oops"
	rescue
		RuntimeError -> "Fixing..."
	end
end

x = RunAfter.without_try
IO.puts(x)


# Else

# An else block will match on the result of the try block if no error occured.

try_else = fn x ->
	try do
		1 / x
	rescue
		ArithmeticError -> :infinity
	else
		y when y < 1 and y > -1 -> :small
		_ -> :large
	end
end
IO.puts(try_else.(0))
IO.puts(try_else.(2))
IO.puts(try_else.(0.5))


# Variable scope

# As with the other constructs in Elixir, variables defined inside of try/(after|catch|rescue)
# blocks will not leak to the outer context.

x = 2
IO.puts("After asigning: #{x}")
try do
	x = "foo"
	IO.puts("Inside Try block: #{x}")
	raise MyError
rescue
	MyError -> IO.puts("On the Rescue block: #{x}")
end
IO.puts("After the try/rescue block: #{x}")
