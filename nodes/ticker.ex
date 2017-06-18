defmodule Ticker do
  require Integer
  @interval 2000 
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name,pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register,pid} ->
        IO.puts "Registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"
        clients 
        |> Enum.with_index
        |> Enum.each(&send_client/1)
      generator(clients)
    end
  end

  def send_client({client, index}) when Integer.is_even(index) do
    send client, {:boop}
  end

  def send_client({client, index}) when Integer.is_odd(index) do
    send client, {:beep}
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__,:receiver,[])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:beep} ->
        IO.puts "beep in client"
        receiver
      {:boop} ->
        IO.puts "boop in client"
        receiver
    end
  end
end
