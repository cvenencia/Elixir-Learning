# Erlang libraries


# The binary module

# This module is useful when we are dealing with data that is not necessarily UTF-8 encoded.
# For example, String.to_charlist returns Unicode codepoints, but :binary.bin_to_list
# returns the raw data bytes.


# Formatted text output

# Elixir does not have a function similar to printf in C, but it has some equivalents.

:io.format("Pi is approximately = ~10.3f~n", [:math.pi])
IO.puts(:io_lib.format("Pi is approximately = ~10.3f", [:math.pi]))

# The first formats to terminal output, and the second one formats to an iolist.


# The crypto module

# It contains hashing functions, digital signatures, encryption and more.

Base.encode16(:crypto.hash(:sha256, "Hello World.")) |> IO.puts


# The digraph module

# Contains functions for dealing with directed graphs. For example, it has
# a function to find the shortest path between two vertices.

digraph = :digraph.new()
coords = [{0,0}, {1,0}, {1,1}]
[v0, v1, v2] = (for c <- coords, do: :digraph.add_vertex(digraph, c))
:digraph.add_edge(digraph, v0, v1)
:digraph.add_edge(digraph, v1, v2)
:digraph.get_short_path(digraph, v0, v2)

# Notice how the digraph is been passed to the function but not reasigned when
# modifying it. This is possible because digraphs are implemented as ETS tables.


# Erlang Term Storage

# The modules 'ets' and 'dets' handle storage of large data structures in memory
# or disk, respectively. They allow you to create a table containing tuples.
# This tables by default are protected, meaning only the owner process can write to it,
# with all other processes only reading. It can be used as a simple database, a key-value
# store or as a cache mechanism.

# The functions in 'ets' will modify the state of the table as a side-effect.

table = :ets.new(:ets_test, [])
# Product | Description
:ets.insert(table, {"Book", "A really long book"})
:ets.insert(table, {"Guitar", "A nice looking guitar"})

# :ets.i(table)


# The queue module

# Self explanatory:

q = :queue.new()
q = :queue.in("A", q)
q = :queue.in("B", q)
q = :queue.in("C", q)
q = :queue.in("D", q)
IO.inspect q
{value, q} = :queue.out(q)
IO.inspect value, label: "Removing from queue"
IO.inspect q


# The rand module

# Self explanatory:

IO.puts(:rand.uniform())
:rand.seed(:exs1024, {123, 123534, 345345})
IO.puts(:rand.uniform())
IO.puts(:rand.uniform(1000))
