defmodule Fibonnaci do

  def fib(n, x, _y) when n == 0,  do: x
  def fib(n, _x, y) when n == 1,  do: y
  def fib(n, x, y),  do: fib(n-1, y, x + y)

end


IO.gets("Please enter N\n")
|> Integer.parse()
|> Kernel.elem(0)
|> Fibonnaci.fib(0, 1)
|> IO.puts()
