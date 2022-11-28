defmodule MixUnusedDiscoveries.Scout.AmqpxTest do
  use ExUnit.Case

  alias MixUnusedDiscoveries.Scout.Amqpx, as: Scout

  import Mock

  defp callbacks_mock(Amqpx.Gen.Consumer),
    do: [
      {Amqpx.Gen.Consumer, :setup, 1},
      {Amqpx.Gen.Consumer, :handle_message, 3},
      {Amqpx.Gen.Consumer, :handle_message_rejection, 2}
    ]

  test "it discovers the amqpx consumer modules and respective :setup/1, :handle_message/3, :handle_message_rejection/2 as defined in the application env" do
    with_mocks [
      {Mix.Project, [], [config: fn -> [app: :my_app, version: 0.1] end]},
      {MixUnusedDiscoveries.Behaviours, [], [callbacks: &callbacks_mock/1]},
      {Application, [],
       [
         get_env: fn
           :my_app, :consumers, [] ->
             [
               %{
                 handler_module: MyApplication.MyFirstConsumer,
                 backoff: 10_000
               },
               %{
                 handler_module: MyApplication.MySecondConsumer,
                 backoff: 10_000
               }
             ]
         end
       ]}
    ] do
      usages = Scout.discover_usages(nil)

      assert {MyApplication.MyFirstConsumer, :setup, 1} in usages
      assert {MyApplication.MyFirstConsumer, :handle_message, 3} in usages
      assert {MyApplication.MyFirstConsumer, :handle_message_rejection, 2} in usages
      assert {MyApplication.MySecondConsumer, :setup, 1} in usages
      assert {MyApplication.MySecondConsumer, :handle_message, 3} in usages
      assert {MyApplication.MySecondConsumer, :handle_message_rejection, 2} in usages
      assert 6 == length(usages)
    end
  end

  test "no usages discovered if no consumer modules are defined in the application env" do
    with_mocks [
      {Mix.Project, [], [config: fn -> [app: :my_app, version: 0.1] end]},
      {MixUnusedDiscoveries.Behaviours, [], [callbacks: &callbacks_mock/1]},
      {Application, [],
       [
         get_env: fn
           :my_app, :consumers, [] -> []
         end
       ]}
    ] do
      usages = Scout.discover_usages(nil)

      assert usages == []
    end
  end
end
