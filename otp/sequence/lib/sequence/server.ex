defmodule Sequence.Server do
  use GenServer
  require Logger

  @vsn "1"
  defmodule State do
    defstruct current_number: 0, stash_pid: nil, delta: 1
  end
  ### External API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__,stash_pid, name: __MODULE__)
  end

  def next_number do
    with number = GenServer.call(__MODULE__, :next_number),
    do: "The next number is #{number}" 
  end

  def increment_number(increment) do
    GenServer.cast(__MODULE__, {:increment_number, increment})
  end

  ### GenServer implementation

  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, %State{current_number: current_number, stash_pid: stash_pid}}
  end

  def handle_call(:next_number, _client_pid, state) do
    {:reply, 
      state.current_number, 
      %{state | current_number: state.current_number + state.delta}
    }
  end

  def handle_cast({:increment_number,delta},state) do
    {:noreply, 
      %{state | current_number: state.current_number + delta, delta: delta}
    }
  end

  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_number
  end

  # define a specific State message
  def format_status(_reason,[_pdict,state]) do
    [data: [{'State', "My current stae is #{inspect state} and i'm happy"}]]
  end

  def code_change("0", old_state = { current_number, stash_pid }, _extra) do
    new_state = %State{
      current_number: current_number,
      stash_pid: stash_pid,
      delta: 1
    }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    { :ok, new_state }
  end
end
