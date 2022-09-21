
defmodule Animals.Behaviour do
  @callback speak() :: String.t()
  @callback type() :: atom()
  @optional_callbacks [speak: 0, type: 0]


  def default_speak do
    "lele!"
  end

  def default_type do
    :lele
  end


  defmacro inspect_callbacks(env) do
    Enum.reduce(
      @optional_callbacks,
      [],
      &Keyword.merge(&1, &2)
    )|>
    Enum.filter(
      fn {callback, arrity} -> not Module.defines?(env.module, {callback, arrity}, :def) end
    )|>
    Enum.map(
      fn {callback, _arrity} ->
        default_callback_name = "default_#{callback}" |> String.to_existing_atom
        quote do
          def unquote(callback)(), do: Kernel.apply(Animals.Behaviour, unquote(default_callback_name), [])
        end
      end
    )

  end

end

defmodule Animals.Descriptor do
  defmacro __using__(_opts) do
    quote do
      @behaviour Animals.Behaviour
      @before_compile {Animals.Behaviour, :inspect_callbacks}

      def describe(), do: "#{type()} says #{speak()}"
    end
  end

end
