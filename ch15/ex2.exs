defmodule Neighbors do
  def listen do
    receive do
      {sender, msg} ->
        send sender, {:ok, msg}
        listen()
    end
  end
end

fred = spawn(Neighbors, :listen, [])
betty = spawn(Neighbors, :listen, [])

send fred, {self(), "betty says hello"}
receive do
  {:ok, msg} ->
    IO.puts msg
end

send betty, {self(), "fred says hello"}
receive do
  {:ok, msg} ->
    IO.puts msg
end
