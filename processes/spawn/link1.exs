defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    spawn_link(Link1, :sad_function,[])
    receive do
      msg -> IO.puts "MSG Received #{inspect msg}"
      after 1000 -> "Nothing happened here"
    end
  end
end
