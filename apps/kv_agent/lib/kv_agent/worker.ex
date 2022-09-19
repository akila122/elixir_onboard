defmodule KVAgent.Worker do
  @moduledoc """
  Basic Key-Value store
  """
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, [name: KVAgent.MyWorker])
  end

  def get(store, key), do: Agent.get(store, &Map.get(&1, key))

  def put(store, key, value), do: Agent.update(store, &Map.put(&1, key, value))

  def delete(store, key), do: Agent.update(store, &Map.delete(&1, key))
end
