defmodule WagonnrTransform do
    @behaviour Transformer
    def transform(wagonnr) do
        String.split(wagonnr, "", parts: String.length(wagonnr)) |> Enum.join(".")
    end
end