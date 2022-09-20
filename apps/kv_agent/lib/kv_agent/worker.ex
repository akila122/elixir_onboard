defmodule KVAgent.Worker do
  @moduledoc """
  Basic Key-Value store
  """
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, [name: KVAgent.Worker.Singleton])
  end

  def get(key), do: Agent.get(KVAgent.Worker.Singleton, &Map.get(&1, key))

  def put(key, value), do: Agent.update(KVAgent.Worker.Singleton, &Map.put(&1, key, value))

  def delete(key), do: Agent.update(KVAgent.Worker.Singleton, &Map.delete(&1, key))
end
