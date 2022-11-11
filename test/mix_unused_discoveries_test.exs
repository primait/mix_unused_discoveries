defmodule MixUnusedDiscoveriesTest do
  use ExUnit.Case

  defmodule A do
    def discover_usages("context") do
      [{Module1, :f, 1}, {Module1, :g, 2}]
    end
  end

  defmodule B do
    def discover_usages("context") do
      [{Module2, :h, 3}]
    end
  end

  test "it discovers all the usages discovered by the given modules" do
    assert [{Module1, :f, 1}, {Module1, :g, 2}, {Module2, :h, 3}] ==
             MixUnusedDiscoveries.discover_usages("context", [A, B])
  end
end
