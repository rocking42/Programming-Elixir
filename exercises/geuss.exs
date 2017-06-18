defmodule Chop do
  def guess(n, a..b) do
    num = a |> Kernel.+(b) |> div(2)
    IO.puts("is it #{num}")
    _next(n, num)
  end

  defp _next(n, n), do: IO.puts("number is #{n}")

  defp _next(n, number) when number < n do
    num = div(number, 2) + number
    IO.puts("is it #{num}")
    _next(n, num)
  end

  defp _next(n, number) when number > n do
    half = number |> div(2)
    IO.puts("is it #{half}")
    _next(n, half)
  end
end

Chop.guess(279, 1..1000)

