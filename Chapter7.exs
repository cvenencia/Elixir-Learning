# Keyword lists

# Split and trim a string
string = "1  2 3  4"
# If the keyword list is at the end of the parameters, the brackets can be skipped
splitted = String.split(string, " ", trim: true)

IO.puts(splitted)

# Keyword lists are lists of paired values, in which the first value is an atom and the second can be anything.

keyword_list = [{:name, "Carlos"}, {:lastname, "Venencia"}]

# This two are equivalent:

IO.puts(keyword_list == [name: "Carlos", lastname: "Venencia"])

# Keys can be added, even duplicates. In this case, the value fetched will be the first one that appears.
# Values from keys can be fetched as follows:

IO.puts(keyword_list[:name])

# Even though it is possible to match keyword lists, it is not ideal since it is necessary to know the number of items and the order must also match

# Maps

# Maps are different from keyword lists in two important ways:
# 1. Maps allow any values (types) as a keys
# 2. Map's keys don't follow any ordering

map = %{:name => "Carlos", "lastname" => "Venencia"}

# Maps are useful with pattern matching. They will always match regardless of the order of the key-value pairs

%{:name => a} = map
IO.puts("a = #{a}")

# Updating a value for a key in a map:

map = %{map | :name => "Andres"}
IO.puts("Name = #{map[:name]}, Lastname = #{map["lastname"]}")

# It is not possible to add key-value pairs with this syntax.
# We can use the keyword syntax for convenience if all keys are atoms
# Also, there is an easier way to access a value from an atom key

map = %{name: "Carlos", lastname: "Venencia"}
IO.puts("Name = #{map.name}, Lastname = #{map.lastname}")


# do blocks are equivalent to keyword lists
# This:

_ = if true do
	"foo"
else
	"bar"
end

# is equivalent to:

s = if true, do: "foo", else: "bar"

IO.puts(s)

# It is also possible to have nested data structures
# Like a keyword list, where each key's value is a map, where some of its key's values are strings, numbers, or lists.

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end

IO.puts("Mary's age: #{users[:mary].age}")
