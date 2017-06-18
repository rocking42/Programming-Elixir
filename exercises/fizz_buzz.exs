fizzbuzz = fn
  0, 0, _c -> "fizzbuzz"
  0, _b, _c -> "fizz"
  _a, 0, _c -> "buzz"
  _a, _b, c -> c
end

remy = fn n -> fizzbuzz.(rem(n,3), rem(n,5), n) end

1..100 |> Enum.map(&IO.puts(remy.(&1)))
