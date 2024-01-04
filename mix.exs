defmodule MixUnusedDiscoveries.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_unused_discoveries,
      version: "0.1.0-rc.0",
      elixir: "~> 1.13",
      package: [
        licenses: ~w[MIT]
      ],
      deps: deps(),
      aliases: aliases()
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
end
