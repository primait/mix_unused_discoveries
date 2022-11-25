defmodule MixUnusedDiscoveries.Scout.ExqMiddlewareTest do
  use ExUnit.Case

  alias MixUnusedDiscoveries.Scout.ExqMiddleware, as: Scout

  import Mock

  defp callbacks_mock(Exq.Middleware.Behaviour),
    do: [
      {Exq.Middleware.Behaviour, :after_failed_work, 1},
      {Exq.Middleware.Behaviour, :after_processed_work, 1},
      {Exq.Middleware.Behaviour, :before_work, 1}
    ]

  defp get_env_mock_correct(:exq, :middleware, _), do: [MyApplication]
  defp get_env_mock_incorrect(:exq, :middleware, _), do: []

  test "it discovers the exq middleware modules and respective :after_failed_work/1, :after_processed_work/1, :before_work/1 as defined in the application env" do
    with_mocks [
      {MixUnusedDiscoveries.Behaviours, [], [callbacks: &callbacks_mock/1]},
      {Application, [], [get_env: &get_env_mock_correct/3]}
    ] do
      usages = Scout.discover_usages(nil)
      assert {MyApplication, :after_failed_work, 1} in usages
      assert {MyApplication, :after_processed_work, 1} in usages
      assert {MyApplication, :before_work, 1} in usages
      assert 3 == length(usages)
    end
  end

  test "no usages discovered if no middleware modules are defined in the application env" do
    with_mocks [
      {MixUnusedDiscoveries.Behaviours, [], [callbacks: &callbacks_mock/1]},
      {Application, [], [get_env: &get_env_mock_incorrect/3]}
    ] do
      usages = Scout.discover_usages(nil)
      assert [] == usages
    end
  end
end
