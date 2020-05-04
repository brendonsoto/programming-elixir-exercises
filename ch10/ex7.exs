defmodule MyList do
  def span(from, to) when from === to do
    [from]
  end
  def span(from, to) when from < to do
    [from | span(from + 1, to)]
  end
  def span(from, to) do
    [from | span(from - 1, to)]
  end

  def enum_primes(n) when n > 2 do
    # generate list from 2..n
    # for each value (y):
    #   generate list from 2..y
    #   map over that list by checking the remainder of dividing y / n
    #   then check that none of the values are zero
    Enum.filter span(2, n), &(enum_check_if_prime(&1))
  end

  def enum_check_if_prime(2), do: true
  def enum_check_if_prime(x) when x > 2 do
    span(2, x-1)
    |> Enum.map(&(rem(x, &1)))
    |> Enum.all?(&(&1 !== 0))
  end

  def stream_primes(n) when n > 2 do
    Stream.filter span(2, n), &(stream_check_if_prime(&1))
  end

  def stream_check_if_prime(2), do: true
  def stream_check_if_prime(x) when x > 2 do
    span(2, x-1)
    |> Stream.map(&(rem(x, &1)))
    |> Enum.all?(&(&1 !== 0))
  end
end
