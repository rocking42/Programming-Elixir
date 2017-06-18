defmodule Comprehen do
  def span(from, to) when from === to, do: [to]
  def span(from, to), do: [from|span(from + 1, to)]

  def prime(to) do
    list = span(2, to)
    products = for x <- list, y <- list, x >= y, x * y <= to, do: x*y
    list -- products
  end
end
