defmodule MixUnusedDiscoveries.Scout.Amqpx do
  @moduledoc """
  Discovers the consumers configured for the [amqpx library](https://hex.pm/packages/amqpx).
  """

  @behaviour MixUnused.Analyzers.Unreachable.Usages
  alias MixUnusedDiscoveries.Behaviours

  @impl true
  def discover_usages(_context) do
    app = Mix.Project.config()[:app]

    for %{handler_module: module} <- Application.get_env(app, :consumers, []),
        {_m, f, a} <- Behaviours.callbacks(Amqpx.Gen.Consumer) do
      {module, f, a}
    end
  end
end
