defmodule WhatIsBetterToPay.MixFile do
  use Mix.Project

  def project do
    [
      app: :what_is_better_to_pay,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
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
      {:ecto_sql, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:csv, "~> 2.3"},
      {:google_maps, "~> 0.11"},
      {:yaml_elixir, "~> 2.4.0"},

      # test
      {:ex_machina, "~> 2.0", only: :test},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
