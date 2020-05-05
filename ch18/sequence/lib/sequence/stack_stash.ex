defmodule Sequence.StackStash do
  use GenServer

  @me __MODULE__

  def start_link(contents) do
    GenServer.start_link(@me, contents, name: @me)
  end

  def get() do
    GenServer.call(@me, { :get })
  end

  def update(new_contents) do
    GenServer.cast(@me, { :update, new_contents })
  end

  # Internal Implementation

  def init(contents) do
    { :ok, contents }
  end

  def handle_call({ :get }, _from, current_contents) do
    { :reply, current_contents, current_contents }
  end

  def handle_cast({ :update, new_contents }, _current_contents) do
    { :noreply, new_contents }
  end
end
