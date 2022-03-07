# Module attributes

# 1. They serve to annotate the module with information used by the user or the VM (documentation)
# 2. They work as constants
# 3. They work as temporary module storage to be used during compilation

defmodule MyModule do

	# 1. Documentation
	@moduledoc """
	Here we can use multi-line strings, enclosed by triple double-quotes.
	
	## Also the use of Markdown is encouraged.
	
	"""

	@doc "This function does..."
	def important_function do
		:ok
	end
	
	# 2. Constants
	@initial_state %{host: "127.0.0.1", port: 3456}
	
	# It is preferred to put the constant to be returned on a function, instead of
	# reading its value on multiple functions, mutiple times. This is because Elixir takes
	# snapshots of its current value everytime it is read. So, if the constant is very expensive
	# to compute, it would slow down significantly compilation.
	
	def initial_state do
		@initial_state
	end
	
	# Accumulating attributes
	
	# Normally when repeating a module attribute will reasign its value. It can
	# be configured to accumulate the values:
	
	Module.register_attribute __MODULE__, :to_accumulate, accumulate: true
	
	@to_accumulate 5
	@to_accumulate :foo
	
	def to_accumulate, do: @to_accumulate
end

IO.inspect(MyModule.initial_state())
IO.inspect(MyModule.to_accumulate())
