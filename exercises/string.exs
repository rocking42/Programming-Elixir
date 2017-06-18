defmodule MyString do
  import String

  def split(list) do
    list 
      |> to_string 
      |> String.split
      |> _split()
  end
  def _split([num1, "+", num2]), do: to_integer(num1) + to_integer(num2)
  def _split([num1, "-", num2]), do: to_integer(num1) - to_integer(num2)
  def _split([num1, "/", num2]), do: to_integer(num1) / to_integer(num2)
  def _split([num1, "*", num2]), do: to_integer(num1) * to_integer(num2)

  def printable(word), do: word |> Enum.all?(&(&1 in 32..126))

  def anagram(word1, word2), do: Enum.sort(word1) === Enum.sort(word2)

  def pad(wordList) do 
    longest = wordList |> Enum.max_by(&String.length/1) |> String.length
    Enum.each(wordList, fn x -> _pad(x, String.length(x), longest) end)
  end
  def _pad(word, wordLength, longestLength) when wordLength === longestLength, do: IO.puts word
  def _pad(word, wordLength, longestLength) do
    pad = round((longestLength - wordLength) / 2)
    IO.puts String.pad_leading(word, wordLength + pad)
  end

  def capitalize(sentence) do
    sentence 
      |> String.split(". ") 
      |> Enum.map(&String.capitalize(&1))
      |> Enum.join(". ")
  end
end
