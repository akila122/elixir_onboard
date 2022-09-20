defmodule KVGenServer.Worker do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(server, key) do
    GenServer.call(server, {:get, key})
  end

  def put(server, key, value) do
    GenServer.call(server, {:put, key, value})
  end

  def delete(server, value) do
    GenServer.call(server, {:delete, value})
  end

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:get, key}, _from, store) do
    {:reply, Map.get(store, key), store}
  end

  @impl true
  def handle_call({:put, key, value}, _from, store) do
    {:reply, :ok, Map.put(store, key, value)}
  end

  @impl true
  def handle_call({:delete, key}, _from, store) do
    {:reply, :ok, Map.delete(store, key)}
  end

end
