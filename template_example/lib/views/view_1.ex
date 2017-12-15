defmodule View1 do
    @behaviour View
    def attributes do
        %{ 
            "wagon_nr:"  => 0,
            "year:"      => 1
         } 
        end

        def print(data) do
            Enum.each(data, fn(x) ->
              line = Enum.reduce(attributes, "", fn({_,v}, string) ->
                if String.length(string) > 0 do
                 Enum.join([string,Enum.at(x, v)],"-") 
                else
                  Enum.at(x, v) 
               end
              end) 
              IO.puts line
            end)
          end
end