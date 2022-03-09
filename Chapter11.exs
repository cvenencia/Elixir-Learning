import IEx.Helpers

# In Elixir, all code runs inside processes (not to be confused with the processes on an OS).
# They run concurrent to each other and communicate via message passing.

# Elixir's processes are extremely lightweight in terms of CPU and memory. For this reason,
# it is even possible to have 100.000's processes running simultaneously.

# spawn
# A basic way to create new processes is with the function 'spawn', which receives a function
# that will run in a new process. 'spawn' returns the PID.

new_pid = spawn(fn -> 1 + 2 end)
IO.puts("Child's PID: #{inspect new_pid}")

# To retrieve the current PID:

current_pid = self()
IO.puts("Parent's PID: #{inspect current_pid}")
IO.puts(Process.alive?(current_pid))
IO.puts(Process.alive?(new_pid))

# Also, it is possible to give a PID a custom name
Process.register(current_pid, :parent_process)

# Sending and receiving messages

# When sending a message to another process, the message is put in the mailbox of
# the other process, and the sender's program continuous. If the receiver process reaches
# a 'receive' block, it will read the mailbox and match the received message with some
# patterns. If there is no message in the mailbox, it will wait until a message arrives, or
# until a specified timeout.

receiver_function = fn ->
	message = receive do
		{:message, msg} -> "Message received at #{inspect self()}: " <> msg
	after
		500 -> "No message received"
	end
	IO.puts(message)
end

receiver = spawn(receiver_function)
send(receiver, {:message, "Hello world"})

send(:parent_process, "Hello world")
send(:parent_process, "Foo bar")
send(:parent_process, "Lorem Ipsum")
flush() # From IEx.Helpers module imported at the top


# Linked processes:

# When an error is raised in a unlinked process, the parent process continues as normal.
# With linked processes, if a child process raises an error, it propagates to the parent process

error_function = fn -> raise "error" end

spawn(error_function)
:timer.sleep(300)
IO.puts("\n#{inspect :parent_process}: This process continues normally\n")

# spawn_link(error_function)
# :timer.sleep(300)
# IO.puts("This will never print")


# Tasks

# 'spawn' and 'spawn_link' are the primitive functions that allow the creation of processes.
# Tasks are a abstraction that builds on top of them. For now, it is enough to know that
# tasks are better for getting error reports.

Task.start(error_function)
:timer.sleep(300)


# States

# States are a way of writing processes that persist information,
# loop infinitely and send and receive messages.


defmodule KeyValue do
	
	def start_link do
		Task.start(fn -> loop(%{}) end)
	end
	
	defp loop(map) do
		receive do
			{:get, key, caller} -> 
				send caller, map |> Map.get(key)
				loop(map)
				
			{:put, key, value} ->
				map |> Map.put(key, value) |> loop()
				
			{:update, key, value} ->
				%{map | key => value} |> loop()
		end
	end
	
end

{:ok, kv} = KeyValue.start_link()
:timer.sleep(500)
# Adding name and lastname
send(kv, {:put, :name, "Carlos"})
send(kv, {:put, :lastname, "Venencia"})
send(kv, {:get, :lastname, :parent_process})
flush()

# Updating lastname
send(kv, {:update, :lastname, "Sayas"})
send(kv, {:get, :lastname, :parent_process})
flush()


# Agents

# Similar things can be accomplished with agents:

{:ok, pid} = Agent.start_link(fn -> %{} end)

Agent.update(pid, fn map -> Map.put(map, :hello, "world") end)
result = Agent.get(pid, fn map -> Map.get(map, :hello) end)

IO.puts(result)
