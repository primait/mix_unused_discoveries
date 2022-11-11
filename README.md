# MixUnusedDiscoveries

A collection of usages discovery modules to use with [mix_unused](https://github.com/primait/mix_unused).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `mix_unused_discoveries` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mix_unused_discoveries, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/mix_unused_discoveries>.

## Usage

Enable the `Unreachable` analyzer and add `MixUnusedDiscovers` to its usages discovery modules:

```elixir
[
  checks: [
    {MixUnused.Analyzers.Unreachable,
      %{
        usages_discovery: [MixUnusedDiscoveries]
      }}
  ]
]
```
