defmodule MixUnusedDiscoveries.Scout.Vmstats do
  @moduledoc """
  Discovers the sink configured for the [vmstats library](https://hex.pm/packages/vmstats_ex).
  """

  @behaviour MixUnused.Analyzers.Unreachable.Usages

  @impl true
  def discover_usages(_context) do
    case Application.get_env(:vmstats, :sink) do
      nil -> []
      module -> [{module, :collect, 3}]
    end
  end
end
