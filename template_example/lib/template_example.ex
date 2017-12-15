defmodule TemplateExample do
  def start do
    data = extract()|> convert_data
    IO.puts "Printing view 1"
    View1.print data
    IO.puts "Printing view 2"
    View2.print data
    
  end

  def extract do
    File.stream!("/Users/cedric/Projects/Elixir/elixir_pattern_examples/template_example/lib/data/wagons.text")
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn (x) -> String.split(x, "-") end)
    |> Enum.to_list()
  end

  def convert_data(data) do
    data = Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op het wagonnummer
      result = WagonnrTransform.transform(Enum.at(line,0))
      line = List.replace_at(line,0,result)
      list ++ [line]
    end)

    Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op de vervoerder
      result = TransporterTransform.transform(Enum.at(line,1))
      line = List.replace_at(line,1,result)
      list ++ [line]
    end)
  end
  
  def print_result(data,view) do
    Enum.each(data, fn(x) ->
      line = Enum.reduce(view.attributes, "", fn({_,v}, string) ->
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
