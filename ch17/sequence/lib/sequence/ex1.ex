defmodule Sequence.Ex1 do
  use GenServer

  def init(contents) when is_list(contents) do
    {:ok, contents}
  end
  def init(_) do
    {:ok, []}
  end

  def handle_call(:pop, _from, current_contents) do
    {:reply, (hd current_contents), (tl current_contents)}
  end

  def handle_cast({:push, value}, current_contents) do
    { :noreply, [value | current_contents] }
  end
end
