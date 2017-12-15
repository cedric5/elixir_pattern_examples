defmodule View1 do
    @behaviour View
    def attributes do
        %{ 
            "wagon_nr:"  => 0,
            "year:"      => 1
         } 
    end
end