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
      mod: {WhatIsBetterToPay, []}
    ]
  end

  defp deps do
    [
      {:nadia, "~> 0.4.1"},
      {:poison, "~> 3.1"}
    ]
  end
end
