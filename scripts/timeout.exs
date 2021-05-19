defmodule LabGenServer do
  use GenServer
  # Server (callbacks)
  @impl true
  def init(_state) do
    {:ok, "", 1_000}
  end

  @impl true
  def handle_call(:hi , _from, state) do
    # Process.sleep(3_000)
    {:reply, "hello", state, 2_000}
  end

  @impl true
  def handle_call(:reply_in_one_second, from, state) do
    Process.send_after(self(), {:reply, from}, 1_000)
    {:noreply, state}
  end

  @impl true
  def handle_info({:reply, from}, state) do
    GenServer.reply(from, :one_second_has_passed)
    {:noreply, state}
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

ret = GenServer.call(pid, :reply_in_one_second)
