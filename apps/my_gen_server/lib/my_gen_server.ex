defmodule MyGenServer do
  @callback handle_call(state::any, args::list, caller_pid::pid) :: tuple
  @callback handle_cast(state::any, args::list, caller_pid::pid) :: tuple
  @callback init(any) :: any
  @optional_callbacks [handle_call: 3, handle_cast: 3, init: 1]

  def call(worker_pid, args) do
    caller_pid = Kernel.self()
    send(worker_pid, {:call, args, caller_pid})
    receive do
      ret -> ret
    end
  end

  def cast(worker_pid, args) do
    caller_pid = Kernel.self()
    send(worker_pid, {:cast, args, caller_pid})
    :ok
  end

  def start_link(module, init_args, ops \\ []) do
    {:ok, initial_state} = Kernel.apply(module, :init, init_args)
    {:ok, Process.spawn(fn -> Kernel.apply(module, :loop, [initial_state]) end, ops)}
  end


  defmacro __using__(_ops) do
    quote do
      @behaviour MyGenServer
      def child_spec(ops) do
        %{
          id: __MODULE__,
          start: {MyGenServer, :start_link, [__MODULE__, [:ok], ops]},
          type: :worker
        }
      end

      def handle_call(msg, caller_pid, state), do: {nil, nil, state}
      def handle_cast(msg, caller_pid, state), do: {nil, nil, state}
      def init(op), do: {:ok, %{}}

      def loop(state) do
        receive do
          {:call, msg, caller_pid} ->
            {_unused, ret, state} = Kernel.apply(__MODULE__, :handle_call, [msg, caller_pid, state])
            Kernel.send(caller_pid, ret)
            Kernel.apply(__MODULE__, :loop, [state])

          {:cast, msg, caller_pid} ->
            {_unused, ret, state} = Kernel.apply(__MODULE__, :handle_cast, [msg, caller_pid, state])

            Kernel.apply(__MODULE__, :loop, [state])

          msg -> Kernel.apply(__MODULE__, :loop, [state])
        end
      end
      defoverridable MyGenServer
    end
  end
end
