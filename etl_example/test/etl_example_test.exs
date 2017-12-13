defmodule EtlExampleTest do
  use ExUnit.Case
  doctest EtlExample

  test "greets the world" do
    assert EtlExample.hello() == :world
  end
end
