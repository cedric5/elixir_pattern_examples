defmodule EtlExample do
  def start do
    extract()
    |> convert_data
    |> print
  end

  def extract do
    File.stream!("/Users/cedric/Projects/Elixir/elixir_pattern_examples/etl_example/lib/data/wagons.text")
    |> Stream.map(&String.strip/1)
    |> Stream.map(fn (x) -> String.split(x, "-") end)
    |> Enum.to_list()
  end

  def convert_data(data) do

    data = Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op het wagonnummer
      result = String.split(Enum.at(line,0), "", parts: String.length(Enum.at(line,0))) |> Enum.join(".")
      line = List.replace_at(line,0,result)
      list ++ [line]
    end)

   data = Enum.reduce(data,[],fn(line,list) -> # Het uitvoeren van de transforms op de vervoerder
      result = "#{Enum.at(line,1)}#" |> String.upcase
      line = List.replace_at(line,1,result)
      list ++ [line]
    end)
    data
  end

  def print(data) do
    IO.puts "Printing View 1"
    Enum.each(data, fn(x) ->
    IO.puts "#{Enum.at(x,0)}-#{Enum.at(x,2)}"
    end)

    IO.puts "Printing view 2"
    Enum.each(data, fn(x) ->
      IO.puts "#{Enum.at(x,1)}-#{Enum.at(x,0)}"
      end)
  end
end



