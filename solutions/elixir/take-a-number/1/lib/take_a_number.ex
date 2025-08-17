defmodule TakeANumber do
  defp loop(state) do
    IO.puts state
    receive do
      {:take_a_number, sender_pid} ->
        new_state = state + 1
        send(sender_pid, new_state)
        loop(new_state)
      {:report_state, sender_pid} -> 
        send(sender_pid, state)
        loop(state)
      :stop -> 
        :ok
      _other -> 
        loop(state)
    end
  end

  def start() do
    state = 0
    spawn(fn -> loop(state) end)
  end
end
