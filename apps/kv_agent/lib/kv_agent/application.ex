defmodule KVAgent.Application do
  @moduledoc """
  Basic Key-Value store App entry
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KVAgent.Worker
    ]

    opts = [strategy: :one_for_one, name: KVAgent.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
