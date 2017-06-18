defmodule Monitor1 do
  import :timer, only: [sleep: 1]

  def bad_function do
    sleep 500
    exit(:bang)
  end

  def run do
    res = spawn_monitor(Monitor1, :bad_function, [])
    IO.puts inspect res
    receive do
      msg ->
        IO.puts "message #{inspect msg}"
      after 1000 ->
        IO.puts "No response"
    end
  end
end

Monitor1.run
