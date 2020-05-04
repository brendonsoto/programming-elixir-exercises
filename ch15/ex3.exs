defmodule Ex do
  import :timer, only: [ sleep: 1 ]

  def my_func do
    receive do
      {sender, msg} ->
        send sender, msg
        exit(:done)
    end
  end

  def run do
    pid = spawn_link(Ex, :my_func, [])
    send pid, {self(), "testing"}
    sleep 500
    receive do
      msg ->
        IO.puts "Received: #{msg}"
    after 1000 ->
        IO.puts "No response"
    end
  end
end

Ex.run
