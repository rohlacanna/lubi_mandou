defmodule LubiMandou.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LubiMandouWeb.Telemetry,
      LubiMandou.Repo,
      {DNSCluster, query: Application.get_env(:lubi_mandou, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LubiMandou.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LubiMandou.Finch},
      # Start a worker by calling: LubiMandou.Worker.start_link(arg)
      # {LubiMandou.Worker, arg},
      # Start to serve requests, typically the last entry
      LubiMandouWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LubiMandou.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LubiMandouWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
