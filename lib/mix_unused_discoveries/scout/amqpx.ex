defmodule MixUnusedDiscoveries.Scout.Amqpx do
  @moduledoc """
  Discovers the consumers configured for the [amqpx library](https://hex.pm/packages/amqpx).
  """

  @behaviour MixUnused.Analyzers.Unreachable.Usages

  @impl true
  def discover_usages(_context) do
    app = Mix.Project.config()[:app]

    for %{handler_module: module} <- Application.get_env(app, :consumers, []),
        mfa <- [{module, :setup, 1}, {module, :handle_message, 3}],
        do: mfa
  end
end