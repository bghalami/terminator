defmodule SkynetTest do
  use ExUnit.Case
  doctest Skynet

  test "skynet server test" do
    assert Skynet.terminator_count() == 0
  end

  test "it can create and kill a terminator" do
    {:ok, pid1} = Skynet.create_terminator()
    {:ok, pid2} = Skynet.create_terminator()
    {:ok, pid3} = Skynet.create_terminator()

    assert Skynet.terminator_count() == 3

    Skynet.kill_terminator(pid1)
    Skynet.kill_terminator(pid2)
    Skynet.kill_terminator(pid3)

    assert Skynet.terminator_count() == 0
  end
end
