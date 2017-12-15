defmodule StrategyExample do
  def start do
    data = extract()|> convert_data
    IO.puts "Printing view 1"
    print_result(data,View1)
    IO.puts "Printing view 2"
    print_result(data,View2)
    
  end

  def extract do
    File.stream!("/Users/cedric/Projects/Elixir/elixir_pattern_examples/strategy_example/lib/data/wagons.txt")
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn (x) -> String.split(x, "-") end)
    |> Enum.to_list()
  end

  def convert_data(data) do
    wagonnr_transforms = ["FormatWagonnrTransform"]
    company_transforms = ["StringToUpcaseTransform","AddHashtagToStringTransform"]

    data = Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op het wagonnummer    
      result = do_transforms(wagonnr_transforms,Enum.at(line,0)) 
      line = List.replace_at(line,0,result)
      list ++ [line]
    end)

   data = Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op de vervoerder  
      result = do_transforms(company_transforms,Enum.at(line,1)) 
      line = List.replace_at(line,1,result)
      list ++ [line]
    end)
    data
  end

  def do_transforms(transform_list,value) do
    Enum.reduce(transform_list, value, fn(transform,result) ->
      apply(String.to_atom("Elixir.#{transform}"), :transform, [result])
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