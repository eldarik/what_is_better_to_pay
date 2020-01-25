defmodule WhatIsBetterToPay.MixFile do
  use Mix.Project

  def project do
    [
      app: :what_is_better_to_pay,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :nadia],
      applications: [:ecto, :postgrex],
      mod: {WhatIsBetterToPay, []}
    ]
  end

  defp deps do
    [
      {:nadia, "~> 0.4.1"},
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.5.1"},
      {:mock, "~> 0.3.0", only: :test},
      {:ecto, "~> 3.0"}, {:postgrex, ">= 0.0.0"}
    ]
  end
end
