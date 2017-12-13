defmodule FormatWagonnrTransform do
    def transform(data) do
        String.split(data, "", parts: String.length(data)) |> Enum.join(".")
    end
end