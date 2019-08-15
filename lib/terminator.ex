defmodule Skynet.Terminator do
  use GenServer

  def start_link( _ ) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    prepare_next()
    battle()
    { :ok, state }
  end

  def prepare_next do
    Process.send_after( self(), :prepare_next, 500 )
  end

  def battle do
    Process.send_after( self(), :battle, 1000 )
  end

  def handle_info(:prepare_next, state) do
    if respawn?() do
      IO.puts("I am born again... in his image")
      Skynet.create_terminator()
    else
      IO.puts("I failed mother")
      prepare_next()
    end
    { :noreply, state }
  end

  def handle_info(:battle, state) do
    if deceased?() do
      IO.puts "I die..."
      Skynet.kill_terminator( self() )
    else
      IO.puts "Y'all can't kill me"
      battle()
      { :noreply, state }
    end
  end

  defp respawn? do
    :rand.uniform <= 0.20
  end

  defp deceased? do
    :rand.uniform <= 0.25
  end
end
