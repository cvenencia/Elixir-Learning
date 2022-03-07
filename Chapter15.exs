# Structs

# Structs are built on top of maps.

# The module has to be compiled first. It is on the other file.

john = %User{}
IO.inspect(john)

# Structs guarantee that only the fields defined on the defstruct will be allowed

# %User{oops: 2}

# Structs use the same syntax for accesing and updating values as maps:

IO.puts(john.name)
jane = %{john | name: "Jane"}
IO.puts(jane.name)

# Elixir underneath is aware that keys can't be added to structs, so this would fail
# jane = %{jane | oops: 5}

# Since structs are bare maps, none of the protocols implemented for maps are available
# for structs. For example, neither Enum nor access behavior. But, since structs are maps,
# they work with the module 'Map'


# Defining a key without a value

# Keys that don't have default values, go at the start of the declaration:
# You can also force certain keys to get given a value when creating the struct.
# If no value is given, it will raise an error.

product = %Product{name: "Computer"}
IO.inspect(product)

# Enforced keys are only guaranteed to exist while creating the struct.
# Nothing prevents that key will be deleted on an update.

_product = %{product | name: nil}
