defmodule MyMoniter do
  def send_crash do
    send(self, "Crash message")
    exit("bad time")
  end

  def receiver do
    receive do
      msg -> IO.inspect msg
    end
  end

  def run do
    pid = spawn_link(MyMoniter, :send_crash, [])
    :timer.sleep(500)

    IO.inspect(pid)

    receiver
  end
end
