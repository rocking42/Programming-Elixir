defmodule TailRecursive do
  def wrong_fact(0), do: 1
  def wrong_fact(n), do: n * wrong_fact(n-1)

  def right_fact(n), do: _fact(n, 1)
  defp _fact(0, acc), do: acc
  defp _fact(n, acc), do: _fact(n-1, acc*n)
end
