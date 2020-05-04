defmodule MyList do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def map([], _), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], val, _), do: val
  def reduce([head | tail], val, func) do
    reduce(tail, func.(head, val), func)
  end

  # EX1
  def mapsum([], _), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  # EX2
  def maxlist([]), do: 0
  def maxlist([a | []]), do: a
  def maxlist([a | [b | rest]]) when a > b, do: maxlist([a | rest])
  def maxlist([head | tail]), do: maxlist(tail)

  # EX3
  def casesar([], _), do: []
  def casesar([head | tail], x), do: [head + x | tail]
end
