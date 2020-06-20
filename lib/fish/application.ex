defmodule Fish.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Fish.Repo,
      # Start the Telemetry supervisor
      FishWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fish.PubSub},
      # Start the Endpoint (http/https)
      FishWeb.Endpoint
      # Start a worker by calling: Fish.Worker.start_link(arg)
      # {Fish.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fish.Supervisor]
    # IO.inspect(System.fetch_env!("URLHOST"))
    ret = Supervisor.start_link(children, opts)
    # IO.inspect(Application.get_all_env(:yourapp))
    # IO.inspect(Fish.Repo.config())
    # IO.inspect(FishWeb.Endpoint.config(:url))
    ret
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FishWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
