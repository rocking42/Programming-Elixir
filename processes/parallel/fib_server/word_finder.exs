defmodule WordFind do
  def run(word) do
    File.ls! 
    |> Enum.map(&File.read!/1) 
    |> Enum.map(fn x -> find_word(x, word) end)
    |> Enum.sum
  end

  def find_word(page, contains) do
    page
    |> String.split()
    |> Enum.filter(fn word -> word === contains end)
    |> length
  end
end
