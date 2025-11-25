defmodule StatePatternTest do
  use ExUnit.Case

  setup do
    pid = StatePattern.start_link()
    %{pid: pid}
  end

  defp send_cmd(pid, cmd) do
    send(pid, {:command, cmd, self()})

    receive do
      {:ok, result} -> result
    after
      100 -> :timeout
    end
  end

  test "initial state is stopped", %{pid: pid} do
    assert send_cmd(pid, :status) == :stopped
  end

  test "playing from stopped", %{pid: pid} do
    assert send_cmd(pid, :play) == :playing
    assert send_cmd(pid, :status) == :playing
  end

  test "pausing from playing", %{pid: pid} do
    send_cmd(pid, :play)
    assert send_cmd(pid, :pause) == :paused
  end

  test "pausing from stopped does nothing. dont even try", %{pid: pid} do
    assert send_cmd(pid, :pause) == :stopped
  end

  test "stopping from any state goes to stopped. something about unstoppable forces meeting immovable states",
       %{pid: pid} do
    send_cmd(pid, :play)
    assert send_cmd(pid, :stop) == :stopped

    send_cmd(pid, :play)
    send_cmd(pid, :pause)
    assert send_cmd(pid, :stop) == :stopped
  end
end
