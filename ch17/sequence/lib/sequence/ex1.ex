defmodule Sequence.Ex1 do
  use GenServer

  #####
  # External API
  def start_link(contents) do
    GenServer.start_link(__MODULE__, contents, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(val) do
    GenServer.cast(__MODULE__, {:push, val})
  end

  #####
  # Internal API

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

  def terminate({reason, _state}) do
    IO.puts reason
  end
end
