defmodule Parallel do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self(), fun.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      # The pin operator is to maintain the order of the processes
      receive do { ^pid, result } -> result end
    end)
  end
end
