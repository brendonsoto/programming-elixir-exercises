defmodule Chop do
  def guess(x, a.._) when x == a, do: IO.puts x
  def guess(x, _..b) when x == b, do: IO.puts x
  def guess(x, a..b) when x > div(a + b, 2) do
    half = div(a + b, 2)
    IO.puts "Is it #{half}"
    guess(x, half..b)
  end
  def guess(x, a..b) do
    half = div(a + b, 2)
    IO.puts "Is it #{half}"
    guess(x, a..half)
  end
end

Chop.guess(273, 1..1000)
