defmodule Photographer.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhotographerWeb.Telemetry,
      Photographer.Repo,
      {DNSCluster, query: Application.get_env(:photographer, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Photographer.PubSub},
      PhotographerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Photographer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    PhotographerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
