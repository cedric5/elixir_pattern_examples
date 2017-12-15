defmodule View do
    @callback attributes() :: map
    @callback print() :: any
end