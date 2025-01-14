defmodule AoC.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [AoC.Input]
    opts = [strategy: :one_for_one, name: Aoc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
