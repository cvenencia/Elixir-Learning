# Debugging

# IO.inspect

# This function, apart from printing the value of a data structure in a
# readable way, also returns the item that was passed to it, allowing to
# chain function calls with IO.inspect:

result = (1..10) |> IO.inspect |> Enum.map(fn x -> x*x end) |>
 IO.inspect |> Enum.sum |> IO.inspect

# We can also add labels:

IO.inspect(result, label: "The result was")

# Along with binding/1, we can see all of the variables and their values

x = fn y, z ->
  IO.inspect binding()
  z <> Integer.to_string(y)
end

x.(10, "A string: ")


# IEx.break!

# While IO.inspect is static, Elixir's interactive shell provides more dynamic
# ways to interact with debugged code.

# IEx.break!

# Allows to create breakpoints wherever we want on the code without modifying its source

defmodule MyModule do
  def some_fun(a,b,c) do
    case {a,b,c} do
      {1,1,1} -> 4
      {2,2,2} -> "Hello"
      _ -> :error
    end
  end
end

# iex(1)> break! MyModule.some_fun
# iex(2)> MyModule.some_fun(1,1,1)
# At this point, the code stops executing and we are able to peak at variable values.

# Debugger

# Elixir ships with a graphical debugger named :debugger

defmodule Example do
  def double_sum(x, y) do
    hard_work(x, y)
  end

  defp hard_work(x, y) do
    x = 2 * x
    y = 2 * y

    x + y
  end
end

# iex(1)> :debugger.start()
# {:ok, #PID<0.106.0>}
# iex(2)> :int.ni(Example)
# {:module, Example}
# iex(3)> :int.break(Example, 3)
# :ok
# iex(4)> Example.double_sum(1, 2)

# After calling the function, it will appear on the GUI of the debugger with a
# break status.
