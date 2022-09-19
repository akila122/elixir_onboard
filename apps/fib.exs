defmodule Fibonnaci do

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n) when is_number(n) and n > 1, do: fib(n-1) + fib(n-2)
  def fib(n) when is_number(n) and n < 0, do: if rem(n+1, 2) == 0, do: fib(-n), else: -fib(-n)

end


IO.gets("Please enter N\n")
|> Integer.parse()
|> Kernel.elem(0)
|> Fibonnaci.fib()
|> IO.puts()
