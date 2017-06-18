defmodule SupSequence.Server do
  use GenServer

  def start_link(current_number) do
    GenServer.start_link(__MODULE__,current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(increment) do
    GenServer.cast(__MODULE__, {:increment_number, increment})
  end

  def handle_call(:next_number, _client_pid, current_number) do
    {:reply, current_number, current_number+1}
  end

  def handle_cast({:increment_number,delta},current_number) do
    {:noreply,current_number+delta}
  end
  # define a specific State message
  def format_status(_reason,[_pdict,state]) do
    [data: [{'State', "My current stae is #{inspect state} and i'm happy"}]]
  end
end
