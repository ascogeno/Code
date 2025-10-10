#OTP CompetentSee said:

#In your editor, implement and test a gen_server for a message queue system. The server should:
# Handle enqueueing of messages.
# Retrieve and dequeue the next message.
# Provide a way to clear the queue.

defmodule MessageQueue do
  use GenServer

  # Stuff you call (make sure you spell em right)

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def enqueue(message) do
    GenServer.cast(__MODULE__, {:enqueue, message})
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  def clear do
    GenServer.cast(__MODULE__, :clear)
  end

  def get_all do
    GenServer.call(__MODULE__, :get_all)
  end

  #Callbacks

  @impl true
  def init(_args) do
    {:ok, []}  # initial queue is empty list
  end

  @impl true
  def handle_cast({:enqueue, message}, state) do
    {:noreply, state ++ [message]}
  end

  @impl true
  def handle_cast(:clear, _state) do
    {:noreply, []}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, :empty, []}
  end

  def handle_call(:dequeue, _from, [first | rest]) do
    {:reply, first, rest}
  end

  @impl true
  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end
end
