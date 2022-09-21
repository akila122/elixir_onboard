defmodule AnimalsTest do
  use ExUnit.Case
  doctest Animals.Descriptor

  test "usage" do

    defmodule Cow do
      use Animals.Descriptor
      def type(), do: :cow
      def speak(), do: "Moo!"
    end

    assert Cow.describe() == "cow says Moo!"


    defmodule Lele do
      use Animals.Descriptor
    end

    assert Lele.describe() == "lele says lele!"

    defmodule HalfLele do
      use Animals.Descriptor
      def type(), do: :cow
    end

    assert HalfLele.describe() == "cow says lele!"

    assert_raise ArgumentError, "Default handler for forgot_to_specify_default not defined", fn ->
      HalfLele.forgot_to_specify_default()
    end

  end
end
