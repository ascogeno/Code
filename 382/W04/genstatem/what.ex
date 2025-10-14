#In your editor, write and test a gen_statem for a chatbot interaction flow. The state machine should:

#Manage conversation states like Greeting, Asking Question, and Providing Response.
#Transition based on user inputs and conversation context.
#Handle fallback states for unrecognized input.

defmodule ChatbotMachine do
  @behaviour :gen_statem
  require Logger

  ## Client API

  def start_link(_args) do
    :gen_statem.start_link({:local, __MODULE__}, __MODULE__, :greeting, [])
  end

  def user_input(text) do
    :gen_statem.cast(__MODULE__, {:user_input, text})
  end

  ## Server Callbacks

  def callback_mode, do: :handle_event_function

  def init(initial_state) do
    #using logger.info was one of Chat's fixes for when this program was busted. It works now, and shouldn't be dependant on using
    Logger.info("🤖 Chatbot current state #{inspect(initial_state)}")
    {:ok, initial_state, %{}}
  end

  def handle_event(:cast, {:user_input, _input}, :greeting, data) do
    Logger.info("🤖 Howdy. Welcome to me, the chatbot")
    {:next_state, :asking_question, data}
  end

  def handle_event(:cast, {:user_input, input}, :asking_question, data) do
    if String.ends_with?(input, "?") do
      Logger.info("🤖 Hold on a sec, imma think on that...")
      {:next_state, :providing_response, %{question: input}}
    else
      Logger.info("🤖 What?")
      {:next_state, :fallback, data}
    end
  end

  def handle_event(:cast, {:user_input, _input}, :providing_response, %{question: q}) do
    Logger.info("🤖 The answer to \"#{q}\" is... 42!")
    {:next_state, :asking_question, %{}}
  end

  def handle_event(:cast, {:user_input, _input}, :fallback, data) do
    Logger.info("🤖 Sorry, I didn’t understand that. Try asking a question!")
    {:next_state, :asking_question, data}
  end

  def handle_event(_, _, _state, _data) do
    {:keep_state_and_data, %{}}
  end
end
