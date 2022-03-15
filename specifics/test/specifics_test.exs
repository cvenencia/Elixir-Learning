defmodule SpecificsTest do
  use ExUnit.Case
  doctest Specifics

  test "greets the world" do
    assert Specifics.hello() == :world
  end
end
