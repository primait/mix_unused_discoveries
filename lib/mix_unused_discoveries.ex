defmodule MixUnusedDiscoveries do
  @moduledoc """
  Enables all the available usages discovery modules.
  """

  @behaviour MixUnused.Analyzers.Unreachable.Usages

  @discoveries [
    MixUnusedDiscoveries.AbsintheDiscovery,
    MixUnusedDiscoveries.AmqpxConsumersDiscovery,
    MixUnusedDiscoveries.ApplicationDiscovery,
    MixUnusedDiscoveries.ExqDiscovery,
    MixUnusedDiscoveries.HttpMockPalDiscovery,
    MixUnusedDiscoveries.PhoenixDiscovery,
    MixUnusedDiscoveries.SupervisorDiscovery,
    MixUnusedDiscoveries.VmstatsDiscovery
  ]

  @impl true
  def discover_usages(context, modules \\ @discoveries) do
    Enum.flat_map(modules, & &1.discover_usages(context))
  end
end
