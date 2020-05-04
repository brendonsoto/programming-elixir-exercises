defmodule Ok do
  def ok!({:ok, data}), do: data
  def ok!(_), do: raise "NOT OK!"
end

IO.puts Ok.ok! {:ok, 3}
Ok.ok! File.open("something")
