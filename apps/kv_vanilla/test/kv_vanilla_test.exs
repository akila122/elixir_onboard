defmodule KVVanillaTest do
  use ExUnit.Case
  doctest KVVanilla.Worker

  setup do
    %{store: start_supervised!(KVVanilla.Worker)}
  end

  test "test operations", %{store: store} do
    assert nil == KVVanilla.Worker.get(store, :test)
    assert :ok == KVVanilla.Worker.put(store, :test, 1)
    assert 1 == KVVanilla.Worker.get(store, :test)
    assert :ok == KVVanilla.Worker.delete(store, :test)
    assert nil == KVVanilla.Worker.get(store, :test)
  end
end
