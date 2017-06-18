defmodule NewProcess do
  def run do
    generate(:fred)
    generate(:betty)
  end

  def test_proc(client) do
    receive do
      token ->
        send(client, token)
    end
  end

  def generate(token) do
    pid = spawn(NewProcess, :test_proc, [self])
    send(pid, token)
    receive do
      response -> IO.puts(response)
    end
  end
end
