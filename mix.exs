defmodule MixUnusedDiscoveries.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_unused_discoveries,
      version: "0.1.0",
      elixir: "~> 1.13",
      package: [
        licenses: ~w[MIT]
      ],
      deps: deps()
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
end
