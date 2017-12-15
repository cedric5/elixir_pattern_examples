defmodule TransporterTransform do
    @behaviour Transformer
    def transform(transporter) do
        "#{transporter}#" |>  String.upcase
    end
end