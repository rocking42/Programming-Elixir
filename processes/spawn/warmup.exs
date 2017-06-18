defmodule WarmUp do
  def run(token1, token2) do
    generate(token1)
    generate(token2)
  end

  def test(client) do
    receive do
      message -> send(client, "Hello #{message}")
    end
  end

  def generate(token) do
    pid = spawn(__MODULE__, :test, [self()])
    send pid, token
    receive do
      message -> IO.puts(message)
    end
  end
end
