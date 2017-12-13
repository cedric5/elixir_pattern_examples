defmodule EtlExample do
  def start do
    extract()
    |> convert_data
    |> print_result
  end

  def extract do
    File.stream!("/Users/cedric/Projects/Elixir/elixir_pattern_examples/etl_example/lib/data/wagons.text")
    |> Stream.map(&String.strip/1)
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

  def print_result(data) do
    Enum.each(data, fn(x) ->
    IO.puts "#{Enum.at(x,0)}-#{Enum.at(x,1)}"
    end)
  end
end
