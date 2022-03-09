defmodule User do
	defstruct name: "John", age: 27
end

# The key :name must have a value when creating a Product
defmodule Product do
	@enforce_keys :name
	defstruct [:name, :description, cost: 10]
end
