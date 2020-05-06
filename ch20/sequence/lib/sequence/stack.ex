defmodule Sequence.Stack do
  use GenServer

  #####
  # External API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(val) do
    GenServer.cast(__MODULE__, {:push, val})
  end

  #####
  # Internal API

  def init(_)  do
    {:ok, Sequence.StackStash.get()}
  end

  def handle_call(:pop, _from, current_contents) do
    {:reply, (hd current_contents), (tl current_contents)}
  end

  def handle_cast({:push, value}, current_contents) do
    { :noreply, [value | current_contents] }
  end

  def terminate({_reason, state}, _current) do
    Sequence.StackStash.update(state)
  end
end
