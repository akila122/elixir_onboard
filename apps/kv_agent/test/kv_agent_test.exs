defmodule KVAgentTest do
  use ExUnit.Case
  doctest KVAgent.Worker

  test "test ops" do
    assert nil == KVAgent.Worker.get(:test)
    assert :ok == KVAgent.Worker.put(:test, 1)
    assert 1 == KVAgent.Worker.get(:test)
    assert :ok == KVAgent.Worker.delete(:test)
    assert nil == KVAgent.Worker.get(:test)
  end
end
