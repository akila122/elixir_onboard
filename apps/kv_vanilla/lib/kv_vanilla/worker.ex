defmodule KVVanilla.Worker do
  def child_spec(ops) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :vanilla_start, [ops]}
    }
  end

  def vanilla_start(_ops) do
    store_init = %{}
    {:ok, Process.spawn(fn -> KVVanilla.Worker.loop(store_init) end, [:link])}
  end

  def loop(store) do
    receive do
      {:call, args, caller_pid} ->
        {store, ret} = handle_call(store, args, caller_pid)
        Kernel.send(caller_pid, ret)
        loop(store)

      {:cast, args, caller_pid} ->
        {store, _ret} = handle_cast(store, args, caller_pid)
        loop(store)
    end
  end

  defp call(worker_pid, args) do
    caller_pid = Kernel.self()
    send(worker_pid, {:call, args, caller_pid})

    receive do
      ret -> ret
    end
  end

  defp cast(worker_pid, args) do
    caller_pid = Kernel.self()
    send(worker_pid, {:cast, args, caller_pid})
    :ok
  end

  defp handle_call(store, {:get, key}, _caller_pid) do
    {store, Map.get(store, key)}
  end

  defp handle_call(store, {:put, key, value}, _caller_pid) do
    {Map.put(store, key, value), :ok}
  end

  defp handle_cast(store, {:delete, key}, _caller_pid) do
    {Map.delete(store, key), :ok}
  end

  def get(worker_pid, key) do
    call(worker_pid, {:get, key})
  end

  def put(worker_pid, key, value) do
    call(worker_pid, {:put, key, value})
  end

  def delete(worker_pid, key) do
    cast(worker_pid, {:delete, key})
  end
end
