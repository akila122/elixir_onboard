defmodule KVAgentTest do
  use ExUnit.Case
  doctest KVAgent.Worker

  setup do
    store = start_supervised!(KVAgent.Worker)
    %{store: store}
  end

  test "test ops", %{store: store} do
    assert nil == KVAgent.Worker.get(store, :test)
    assert :ok == KVAgent.Worker.put(store, :test, 1)
    assert 1 == KVAgent.Worker.get(store, :test)
    assert :ok == KVAgent.Worker.delete(store, :test)
    assert nil == KVAgent.Worker.get(store, :test)
  end
end
