defmodule MixUnusedDiscoveries.MixProject do
  use Mix.Project

  @source_url "https://github.com/primait/mix_unused_discoveries"
  @version "0.1.0"

  def project do
    [
      app: :mix_unused_discoveries,
      version: @version,
      elixir: "~> 1.13",
      package: package(),
      deps: deps(),
      aliases: aliases(),
      docs: docs(),
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :pls, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:mix_unused, github: "primait/mix_unused"},
      {:mock, "~> 0.3.7", only: :test}
    ]
  end

  defp aliases do
    [
      check: [
        "compile --all-warnings --ignore-module-conflict --warnings-as-errors --debug-info",
        "format --check-formatted mix.exs \"lib/**/*.{ex,exs}\" \"test/**/*.{ex,exs}\" \"priv/**/*.{ex,exs}\" \"config/**/*.{ex,exs}\"",
        "deps.unlock --check-unused",
        "credo -a --strict",
        "dialyzer"
      ]
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: @version,
      formatters: ["html"]
    ]
  end

  defp package do
    [
      description: "A collection of usages discovery modules to use with mix_unused",
      name: "mix_unused_discoveries",
      maintainers: ["Prima"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
