defmodule MyEnum do
  def all?([], _func), do: true
  def all?([head|tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _func), do: []
  def each([head|tail], func), do: [func.(head)|each(tail, func)]

  def filter([], _func), do: []
  def filter([head|tail], func) do
    if(func.(head)) do
      [head|filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  
  def split(list, n), do: _split(list, [], n)
  defp _split([], front, _n), do: [Enum.reverse(front), []]
  defp _split(tail, front, 0), do: [Enum.reverse(front), tail]
  defp _split([head|tail], front, count) do
    _split(tail, [head|front], count-1)
  end

  def take(list, n), do: list |> split(n) |> hd

  def flatten(list), do: _flatten(list, [])
  def _flatten([], all), do: all
  def _flatten([head|tail], all) do 
    if(is_list(head)) do
      _flatten(head, _flatten(tail, all))
    else
      [head|_flatten(tail, all)]
    end
  end
end
