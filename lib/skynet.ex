defmodule Skynet do
  alias Skynet.TerminatorSupervisor
  alias Skynet.Terminator

  def terminator_count() do
    Supervisor.count_children(TerminatorSupervisor).active
  end

  def create_terminator() do
    DynamicSupervisor.start_child(TerminatorSupervisor, Terminator)
  end

  def kill_terminator(pid) do
    if terminator_count() == 1 do
      IO.puts "You win...this time"
      System.stop()
    else
      DynamicSupervisor.terminate_child(TerminatorSupervisor, pid)
    end
  end

  def list_children do
    Supervisor.which_children(TerminatorSupervisor)
  end

end
