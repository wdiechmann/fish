defmodule FishWeb.HeroComponent do
  #
  # this will eventually be a component but for now
  # it's a (partial) view
  #
  use FishWeb, :live_view

  def mount(_params, _, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 30000)
    scans = Enum.random(1000..1750)
    socket = assign(socket, scans: scans)
    # temperature = Thermostat.get_user_reading(user_id)
    {:ok, socket}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 30000)
    scans = Enum.random(1000..1750)
    socket = assign(socket, scans: scans)
    {:noreply, socket}
  end
end
