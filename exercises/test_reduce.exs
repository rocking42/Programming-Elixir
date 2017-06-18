defmodule Reduce do
  def this([],_func,acc), do: acc
  def this([head|tail],func,acc), do: this(tail, func, func.(acc, head))

  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n), do: fib(n-1) + fib(n-2)
end
