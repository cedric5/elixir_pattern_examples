defmodule AddHashtagToStringTransform do
    def transform(data) do
        "#{data}#"
    end
end