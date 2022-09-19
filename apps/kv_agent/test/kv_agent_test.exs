defmodule KVAgentTest do
  use ExUnit.Case
  doctest KVAgent.Worker

  test "test ops" do
    assert nil == KVAgent.Worker.get(KVAgent.MyWorker, :test)
    assert :ok == KVAgent.Worker.put(KVAgent.MyWorker, :test, 1)
    assert 1 == KVAgent.Worker.get(KVAgent.MyWorker, :test)
    assert :ok == KVAgent.Worker.delete(KVAgent.MyWorker, :test)
    assert nil == KVAgent.Worker.get(KVAgent.MyWorker, :test)
  end
end
