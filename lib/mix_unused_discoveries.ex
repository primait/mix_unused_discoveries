defmodule MixUnusedDiscoveries do
  @moduledoc """
  Enables all the available usages discovery modules.
  """

  @behaviour MixUnused.Analyzers.Unreachable.Usages

  @discoveries [
    MixUnusedDiscoveries.Scout.Absinthe,
    MixUnusedDiscoveries.Scout.Amqpx,
    MixUnusedDiscoveries.Scout.Application,
    MixUnusedDiscoveries.Scout.ExqEnqueue,
    MixUnusedDiscoveries.Scout.ExqMiddleware,
    MixUnusedDiscoveries.Scout.HttpMockPal,
    MixUnusedDiscoveries.Scout.Phoenix,
    MixUnusedDiscoveries.Scout.Supervisor,
    MixUnusedDiscoveries.Scout.Vmstats
  ]

  @impl true
  def discover_usages(context, modules \\ @discoveries) do
    Enum.flat_map(modules, & &1.discover_usages(context))
  end
end
