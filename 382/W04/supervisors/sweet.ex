#In your editor, implement a supervisor to monitor uptime of children. It should:

#Restart children after a crash.

#Log uptime statistics when each child terminates.

# uptime_app.exs
defmodule UptimeWorker do
  use GenServer
  require Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{})
  end

  def crash(pid) do
    GenServer.cast(pid, :crash)
  end

  def init(state) do
    Logger.info("UptimeWorker started.")
    {:ok, Map.put(state, :start_time, System.system_time(:second) #there are two ways to get these, and the first one I tried gave negative time. very weird
    )}
  end

  def handle_cast(:crash, _state) do
    raise "Simulated crash"
  end

  def terminate(reason, state) do
    uptime = System.system_time(:second) - state[:start_time]
    Logger.info("UptimeWorker terminating (#{inspect(reason)}). Uptime: #{uptime} seconds")
    :ok
  end
end

defmodule UptimeSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      %{
        id: UptimeWorker,
        start: {UptimeWorker, :start_link, [[]]},
        restart: :permanent,
        shutdown: 5000,
        type: :worker
      }
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule UptimeApp do
  require Logger
  def run do
    {:ok, sup_pid} = UptimeSupervisor.start_link()

    [{_, worker_pid, _, _}] = Supervisor.which_children(sup_pid)

    Logger.info("Working on it. Crashing worker in 3 seconds or so...")

    Process.sleep(3000)
    UptimeWorker.crash(worker_pid)

    Logger.info("Waiting to observe restart...")
    Process.sleep(3000)

    Logger.info("Done boss.")
  end
end

UptimeApp.run()
