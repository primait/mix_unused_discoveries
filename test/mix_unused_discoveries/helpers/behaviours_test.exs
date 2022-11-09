defmodule MixUnusedDiscoveries.Helpers.BehavioursTest do
  use ExUnit.Case

  alias MixUnusedDiscoveries.Helpers.Behaviours

  test "get module callbacks" do
    assert [{MixUnused.Analyzers.Unreachable.Usages, :discover_usages, 1}] =
             Behaviours.callbacks(MixUnused.Analyzers.Unreachable.Usages)
  end
end
