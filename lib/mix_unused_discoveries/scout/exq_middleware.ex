defmodule MixUnusedDiscoveries.Scout.ExqMiddleware do
  @moduledoc """
  Discovers functions implemented from the behaviour defined in [Exq.Middleware.Behaviour](https://hexdocs.pm/exq/Exq.Middleware.Behaviour.html#content) using the project configuration.
  """

  alias MixUnused.Analyzers.Unreachable.Usages.Context
  alias MixUnusedDiscoveries.Behaviours

  @behaviour MixUnused.Analyzers.Unreachable.Usages

  @spec discover_usages(Context.t()) :: [mfa()]
  def discover_usages(_context) do
    for m <- Application.get_env(:exq, :middleware, []),
      {_m, f, a} <- Behaviours.callbacks(Exq.Middleware.Behaviour) do
        {m, f, a}
      end
  end
end
