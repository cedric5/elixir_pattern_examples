defmodule View2 do
    @behaviour View
    def attributes do
        %{
            "transporter:" => 2,
            "wagon_nr:"    => 0
        }
    end
end