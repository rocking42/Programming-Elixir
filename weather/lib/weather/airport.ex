defmodule Weather.Airport do
  def fetch do
    "http://w1.weather.gov/xml/current_obs/KDTO.xml"
    |> HTTPoison.get()
    |> handle_response
  end

  def handle_response({:ok, data}) do
    {body, _} = data.body
    |> :binary.bin_to_list
    |> :xmerl_scan.string
    body
  end
end
