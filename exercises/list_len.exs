defmodule MyList do
  def sum([head|tail]), do: _sum(tail, head)
  defp _sum([head|tail], total), do: _sum(tail, total + head)
  defp _sum([], total), do: total

  def recur([]), do: 0
  def recur([head|tail]), do: head + recur(tail)

  def len([]), do: 0 
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def map([], _func), do: []
  def map([head|tail], func) do 
    [func.(head)| map(tail, func)]
  end

  def reduce([], value, _), do: value
  def reduce([head|tail], value, func) do
    reduce(tail, func.(value, head), func)
  end

  def mapsum([], _func), do: 0
  def mapsum([head| tail], func) do
    func.(head) + mapsum(tail, func)
  end

  def max([]), do: 0
  def max([head|tail]), do: Kernel.max(head, max(tail))

  def ceasar([], _add), do: [] 
  def ceasar([head|tail], add) when head + add <= ?z,
    do: [ head + add | ceasar(tail, add)]
  def ceasar([head|tail], add), 
    do: [head - 26 + add | ceasar(tail, add)]
end



