defmodule CustomSigils do
	def sigil_x(string, [?u]), do: String.upcase(string)
	def sigil_x(string, [?l]), do: String.downcase(string)
end
