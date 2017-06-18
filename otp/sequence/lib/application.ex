defmodule Sequence do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      worker(Sequence.StackSupervisor, [Application.get_env(:sequence, :stack)]),
      worker(Sequence.Supervisor, [Application.get_env(:sequence, :number)])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end
end
