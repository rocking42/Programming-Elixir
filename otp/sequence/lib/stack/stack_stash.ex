defmodule Sequence.StackStash do
  use GenServer

  ### External API

  def start_link(current_stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__,current_stack)
  end

  def save_value(pid, stack) do
    GenServer.cast(pid, {:save_value, stack})
  end

  def get_value(pid) do
    GenServer.call(pid, :get_value)
  end

  ### GenServer implementation

  def handle_call(:get_value,_from,current_stack) do
    {:reply, current_stack, current_stack}
  end

  def handle_cast({:save_value, stack},_current_value) do
    {:noreply, stack}
  end
end
