defmodule Orders do
  defp orders do
    [[ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount:  50.00 ]]
  end

  defp tax do
    [NC: 0.075, TX: 0.08]
  end
  # Trying out comprehensions
  def to do
    first = for [id,{_,area},{_,amount}] <- orders(), {taxArea,taxed} <- tax(), taxArea === area do
      [id, ship_to: area, net_amount: amount, total_amount: amount + amount * taxed]
    end

    [{taxOne,_},{taxTwo,_}] = tax()

    second = for [id,{_,area},{_,amount}] <- orders(), taxOne !== area, taxTwo !== area do
      [id, ship_to: area, net_amount: amount, total_amount: amount]
    end

    second ++ first
  end
  # Much better implementation use the Keyword module more
  def to2(allOrders), do: allOrders |> Enum.map(&add_total(&1, tax()))
  defp add_total(order=[_,{_,state},{_,amount}], taxes) do
    tax_rate = Keyword.get(taxes, state, 0)
    Keyword.put(order, :total_amount, amount * tax_rate + amount)
  end

  def file_parse(file) do
    file 
    |> File.stream!() 
    |> Stream.drop(1) 
    |> Enum.map(&data_parse/1)
    |> Enum.map(&convert_line/1)
    |> Enum.to_list
    |> to2() 
  end

  def data_parse(line) do
    line 
      |> String.trim
      |> String.split(",") 
  end

  def convert_line([id, state, amount]) do
    [id: id |> String.to_integer,
    ship_to: state |> String.trim_leading(":") |> String.to_atom,
    net_amount: amount |> String.to_float]
  end
end
Orders.file_parse("orders.txt")
