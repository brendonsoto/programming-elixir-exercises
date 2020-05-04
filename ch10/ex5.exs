defmodule MyEnum do
  def all([], _) do
    true
  end
  def all([head | tail], func) do
    func.(head) && all(tail, func)
  end

  def each([], _), do: :ok
  def each([h|t], f) do
    f.(h)
    each(t, f)
  end

  def filter([], _), do: []
  def filter([h|t], f) do
    if (f.(h)) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  def split([], _), do: {[], []}
  def split(xs, 0), do: {[], xs}
  def split([h|t], n) when n > 0 do
    {keep, rest} = split(t, n-1)
    {[h | keep], rest}
  end
  # Had to look online for reverse
  # The common solution is to add the length of the list to n as a way of inverting the count
  # I thought length was a library function haha
  # def split(xs, n) do # when n is negative
  #   {keep, rest} = split(t, n+1)
  #   {keep, last}
  # end
  def split(xs, n), do: split(xs, n + length(xs))
end
