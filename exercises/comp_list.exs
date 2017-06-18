defmodule CompList do
  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 28, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 26, 22, 0.095],
      [1366232822, 27, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end

  def find_temp(_n, []), do: []
  def find_temp(n, [head=[_,_,n,_] | tail]), do: [head|find_temp(n, tail)]
  def find_temp(n, [_head| tail]), do: find_temp(n, tail)

  def find_temp_less_than(_n, []), do: []
  def find_temp_less_than(n, [head=[_,_,temp,_]|tail]) 
    when temp < n,
    do: [head|find_temp_less_than(n, tail)]
  def find_temp_less_than(n, [_|tail]), do: find_temp_less_than(n, tail)

  def span(from, to) when from === to, do: [to]
  def span(from, to), do: [from | span(from + 1, to)]
end
