defmodule NewFib do
  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n) when n < 0, do: "wrong input"
  def fib(n), do: fib(n-1) + fib(n-2)

  def fact(0), do: 1
  def fact(n), do: n * fact(n-1)
end
