defmodule WhatIsBetterToPay.Repo do
  use Ecto.Repo,
    otp_app: :what_is_better_to_pay,
    adapter: Ecto.Adapters.Postgres,
    types: WhatIsBetterToPay.PostgresTypes

  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
