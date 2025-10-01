#In your editor, write a stateful process to simulate a basic scheduler that maintains a queue of tasks and executes them one by one.


defmodule TaskScheduler do

  def start do
    tasks = [
      fn -> IO.puts("Task 1: Starting up")end,
      fn -> IO.puts("Tibask 2: Running the simulations")end,
      fn -> IO.puts("Timomthee Chalamet...")end
    ]

    IO.puts("Starting task scheduler...\n")
    loop(tasks)
  end

  defp loop([]) do
    IO.puts("\nAll tasks completed. Peace out")
  end

  defp loop([current | rest]) do
    IO.puts(("Running upcoming task..."))
    current.()
    :timer.sleep(500) #testing timers cause I want a pause for dramatic effect
    loop(rest)
  end

end

TaskScheduler.start()
