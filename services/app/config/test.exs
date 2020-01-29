use Mix.Config

config :what_is_better_to_pay,
  google_docs_api: WhatIsBetterToPay.Services.GoogleDocs.Test

config :what_is_better_to_pay, WhatIsBetterToPay.Repo,
  pool: Ecto.Adapters.SQL.Sandbox,
  url: System.get_env("DATABASE_URL"),
  ownership_timeout: 99_999_999

config :logger, level: :error
