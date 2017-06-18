defmodule Weather.CLI do
  import Weather.XML

  @start '/current_observation'
  
  @line '-----------------------------+---'

  def main, do: process()

  def process do 
    Weather.Airport.fetch
    |> parse_xml
    |> display_data
  end

  def parse_xml(xml) do
    location = :xmerl_xpath.string('#{@start}/location', xml)
    |> hd |> xmlElement(:content) |> hd |> xmlText(:value)
    
    weather = :xmerl_xpath.string('#{@start}/weather', xml)
    |> hd |> xmlElement(:content) |> hd |> xmlText(:value)

    temp_c = :xmerl_xpath.string('#{@start}/temp_c', xml)
    |> hd |> xmlElement(:content) |> hd |> xmlText(:value)
    [location,weather,temp_c]
  end

  def display_data([location, weather, temp_c]) do
    title = "location                    |weather|temp"
    IO.puts "#{title}\n#{@line}\n#{location}|#{weather}  |#{temp_c}"
  end
end
