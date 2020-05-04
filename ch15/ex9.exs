defmodule CatCounter do
  def inFile(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :cat, dir, client } ->
        send client, { :answer, dir, get_cats(dir), self() }
        inFile(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def get_cats(dir) do
    me = self()
    dir
    |> File.ls!
    |> Enum.map(fn file ->
        spawn_link fn -> (send me, {self(), File.read!(file)}) end
    end)
    |> Enum.map(fn pid ->
      receive do { ^pid, result } -> count_cats(result) end
    end)
    |> Enum.sum
  end

  def count_cats(str) do
    String.split(str) # remove whitespaces
    |> Enum.reduce(0, (fn word, count -> is_cat(word, count) end))
  end

  defp is_cat("cat", x), do: x + 1
  defp is_cat(_str, x), do: x
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [ next | tail ] = queue
        send pid, {:cat, next, self()}
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end
end

# to_process = List.duplicate(37, 20)
#
# Enum.each 1..10, fn num_processes ->
#   {time, result} = :timer.tc(
#     Scheduler, :run,
#     [num_processes, FibSolver, :fib, to_process]
#   )
#
#   if num_processes == 1 do
#     IO.puts inspect result
#     IO.puts "\n #   time (s)"
#   end
#   :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
# end
dirs_to_process = ["."]
{time, result} = :timer.tc(
  Scheduler, :run,
  [4, CatCounter, :inFile, dirs_to_process]
)

IO.puts time/1000000.0
IO.puts inspect(result)
