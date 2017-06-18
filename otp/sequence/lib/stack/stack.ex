defmodule Sequence.Stack do
  use GenServer

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop_number do
    GenServer.call(__MODULE__, :pop)
  end

  def push_number(new_value) do
    GenServer.cast(__MODULE__, {:push, new_value})
  end

  def init(stash_pid) do
    current_stack = Sequence.StackStash.get_value(stash_pid)
    {:ok, {current_stack, stash_pid}}
  end

  def handle_call(:pop,_from,{stack, stash_pid}) do
    case stack do
      [_pop|stack_tail] -> {:reply, stack, {stack_tail, stash_pid}}
    end
  end

  def handle_cast({:push, new_value}, {stack, stash_pid}) do
    {:noreply, {[new_value|stack], stash_pid}}
  end

  def terminate(_reason, {value, stash_pid}) do
    Sequence.StackStash.save_value(stash_pid, value)
  end
end

