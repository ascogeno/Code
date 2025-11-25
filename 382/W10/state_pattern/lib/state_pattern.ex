# In your editor, create a state function for a music player. Manage states like playing, paused, and stopped.

defmodule StatePattern do
  def start_link(initial_state \\ %{status: :stopped}) do
    spawn_link(fn -> loop(initial_state) end)
  end

  defp loop(state) do
    receive do
      {:command, :play, sender} ->
        new_state = handle_play(state)
        send(sender, {:ok, new_state.status})
        loop(new_state)

      {:command, :pause, sender} ->
        new_state = handle_pause(state)
        send(sender, {:ok, new_state.status})
        loop(new_state)

      {:command, :stop, sender} ->
        new_state = handle_stop(state)
        send(sender, {:ok, new_state.status})
        loop(new_state)

      {:command, :status, sender} ->
        send(sender, {:ok, state.status})
        loop(state)

      _ ->
        loop(state)
    end
  end

  defp handle_play(%{status: :playing} = state), do: state
  defp handle_play(_), do: %{status: :playing}

  defp handle_pause(%{status: :playing}), do: %{status: :paused}
  defp handle_pause(state), do: state

  defp handle_stop(_), do: %{status: :stopped}
end
