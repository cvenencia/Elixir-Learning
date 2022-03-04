# The IO module

# I have been using it since chapter 1, so there is nothing to add here, apart from:

response = IO.gets("Tell me something: ")
IO.puts("You responded: #{response}")


# The File module

# Contains functions that allow us to open files as IO devices.
# It has functions named after their UNIX equivalent, such as rm, mkdir, etc

{:ok, file} = File.open("./.test", [:write])
IO.binwrite(file, "Hello world written on a file from Elixir")

File.close(file)
{:ok, file_content} = File.read("./test.txt")

IO.puts(file_content)

# Handling errors with files

# If it is desired to handle errors while working with files, we should use
# pattern matching, with the function 'read' from the File module:

case File.read("./error") do
	{:ok, body} -> IO.puts(body)
	{:error, reason} -> IO.puts(reason)
end

# If instead it is desired to raise errors, we should simply use the function
# 'read!' from the File module:

# File.read!("./error") -> Raises File.Error

# The Path module

# Most of the functions in the File module expect paths as arguments. Most of the time,
# those paths will be regular binaries (strings). This module provides facilities for
# working with such paths.

IO.puts(Path.join("foo", "bar"))
IO.puts(Path.expand("."))

# Files as processes

# In Elixir, the IO module works with processes, meaning a file is a process.
# If, for example, you try to write to a closed file, it is like sending a message to
# a process that has been terminated.
