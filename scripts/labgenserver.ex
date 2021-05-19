defmodule LabGenServer do
  use GenServer
  # Server (callbacks)
  @impl true
  def init(_state) do
    {:ok, "", 1_000}
  end

  @impl true
  def handle_call(:hi , _from, _state) do
    # Process.sleep(3_000)
    {:reply, "hello", "", 2_000}
  end

  @impl true
  def handle_info(msg, state) do
    IO.inspect({"handle_info", msg, state})
    {:noreply, state}
  end
end

# Start the server
{:ok, pid} = GenServer.start_link(LabGenServer, "", timeout: 1_000)
IO.inspect(pid)

# This is the client
ret = GenServer.call(pid, :hi, 2_000)
IO.inspect(ret)
#=> :hello
