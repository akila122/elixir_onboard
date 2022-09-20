defmodule KVGenServerTest do
  use ExUnit.Case
  doctest KVGenServer.Worker

  setup do
    %{store: start_supervised(KVGenServer.Worker)}
  end

  test "test ops", %{store: store} do
    assert nil == KVGenServer.Worker.get(store, :test)
    assert :ok == KVGenServer.Worker.put(store, :test, 1)
    assert 1 == KVGenServer.Worker.get(store, :test)
    assert :ok == KVGenServer.Worker.delete(store, :test)
    assert nil == KVGenServer.Worker.get(store, :test)
  end
end
