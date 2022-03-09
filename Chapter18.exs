# Sigils

# Sigils provide an extensive way of working with different structures via textual
# representations. Sigils start with ~, followed by a character that identifies the
# sigil, and then a delimiter. Finally, some modifiers may be added at the end of
# the sigil.

# Delimiters allowed: //, ||, "", '', (), [], {}, <>
# The reason Elixir allows multiple delimiters is to make it easier to write
# specific sigils that may containt special characters, so those don't have to be
# escaped every time.


# Regular expressions (regex)

# These are represented with the sigil ~r
# Most of the modifiers commonly used with regex are usable in elixir.
# For example, the modifier 'i' makes the regex case insensitive.

regex = ~r"foo|bar"i

IO.puts("foo" =~ regex)
IO.puts("BAR" =~ regex)


# Strings, charlists and word lists

string = ~s(This is a string that doesn't requiere to escape "the double quotes")
IO.puts(string)

charlist = ~c/This is a charlist that contains 'single quotes'/
IO.puts(charlist)

wordlist = ~w|List of the words contained in this sigil|c
IO.inspect(wordlist)
# Wordlist accept 'c', 's' and 'a' modifiers. These specify the data type of the words.


# Interpolation and escaping in string literals

# In case we want to avoid escaping and interpolation in sigils, Elixir provides
# uppercase sigils, which altogether ignores interpolation and escaping:

escaped_string = ~s"String with interpolation: #{floor(2.4)}"
not_escaped_string = ~S"String without interpolation: #{floor(2.4)}"

IO.puts(escaped_string <> "\n" <> not_escaped_string)


# Calendar sigils

# Date: struct that contains year, month, day and calendar
d = ~D|2022-03-07|
IO.puts(d.month)

# Time: struct that contains hour, minute, second, microsecond and calendar
t = ~T/16:45:24.645/
IO.inspect(t.microsecond)

# NaiveDateTime: struct that contains fields from both Date and Time.
# Important thing to note: this type does not containt timezone information.
# Meaning a NaiveDateTime may not exist, or exist twice in a timezone.
ndt = ~N<2022-07-15 10:45:24.224>
IO.puts(ndt)

# UTC DateTime: struct that contains fields from NaiveDateTime, plus the timezone.
utc = ~U'2019-10-31 19:59:03Z'
IO.puts(utc.time_zone)


# Custom sigils

# We can create our own sigils like so:

import CustomSigils # Chapter18_Sigils.exs

IO.puts(~x"Hello World"u)
IO.puts(~x"Hello World"l)
