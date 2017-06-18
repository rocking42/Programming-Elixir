defmodule Fizz do
  def case(n) do
    case { rem(n, 3), rem(n, 5), n } do
      {0,0,_} -> IO.puts "FizzBuzz"
      {0,_,_} -> IO.puts "Fizz"
      {_,0,_} -> IO.puts "Buzz"
      _ -> IO.puts n
    end
  end

  def ok!({:ok, data}), do:  data
  def ok!({_, error}), do: raise error
  def ok!(_), do: raise "Uncaught exception snuck in"
end
