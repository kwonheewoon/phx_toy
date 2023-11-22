defmodule PhxToy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxToyWeb.Telemetry,
      PhxToy.Repo,
      {DNSCluster, query: Application.get_env(:phx_toy, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxToy.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxToy.Finch},
      # Start a worker by calling: PhxToy.Worker.start_link(arg)
      # {PhxToy.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxToyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxToy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxToyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
