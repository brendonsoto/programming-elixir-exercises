defmodule Sequence.Stash do
  use GenServer

  @me __MODULE__

  defmodule State do
    defstruct(initial_number: 0, delta: 1)
  end

  def start_link(initial_number) do
    GenServer.start_link(__MODULE__, initial_number, name: @me)
  end

  def get() do
    GenServer.call(@me, { :get })
  end

  def update(new_number) do
    GenServer.cast(@me, { :update, new_number })
  end

  # Server Implementation

  def init(initial_number) do
    state = %State{ initial_number: initial_number, delta: 1 }
    { :ok, state }
  end

  def handle_call({ :get }, _from, state) do
    { :reply, state, state }
  end

  def handle_cast({ :update, new_state }, _current_number) do
    state = %State{ initial_number: new_state.initial_number, delta: new_state.delta }
    { :noreply, state }
  end
end
