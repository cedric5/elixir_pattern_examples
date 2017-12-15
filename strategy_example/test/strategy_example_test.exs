defmodule StrategyExampleTest do
  use ExUnit.Case
  doctest StrategyExample

  test "greets the world" do
    assert StrategyExample.hello() == :world
  end
end
