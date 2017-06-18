[1,2,3,4] |> Enum.map(&(&1 + 2))
[1,2,3,4] |> Enum.each(&IO.inspect(&1))
