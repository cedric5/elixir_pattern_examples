defmodule TemplateExampleTest do
  use ExUnit.Case
  doctest TemplateExample

  test "greets the world" do
    assert TemplateExample.hello() == :world
  end
end
