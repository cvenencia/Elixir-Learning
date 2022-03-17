defmodule Unless do
  # Macros are about receiving quoted expressions and transforming
  # them into something else. Constructs such as unless, defmacro,
  # def, defprotocol; are implemented in pure Elixir, often as a
  # macro.
  def fun_unless(clause, do: expression) do
    if(!clause, do: expression)
  end

  defmacro macro_unless(clause, do: expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

# Elixir macros have late resolution. This guarantees that a
# variable defined inside a quote won’t conflict with a
# variable defined in the context where that macro
# is expanded

defmodule Hygiene do
  defmacro interference do
    quote do: var!(a) = 1
  end
end

defmodule HygieneTest do
  def go do
    require Hygiene
    a = 13
    Hygiene.interference()
    a
  end
end

defmodule Sample do
  defmacro initialize_to_char_count(variables) do
    Enum.map(variables, fn name ->
      var = Macro.var(name, nil)
      length = name |> Atom.to_string |> String.length

      quote do
        unquote(_) <> unquote(var) = unquote(length)
      end
    end)
  end

  def run do
    initialize_to_char_count [:red, :green, :yellow]
    # [red, green, yellow]
  end
end

IO.puts HygieneTest.go
