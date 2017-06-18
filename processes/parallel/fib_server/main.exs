defmodule Expo do
  def start(0), do: 1
  def start(n), do: n * start(n-1)
end
