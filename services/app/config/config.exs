use Mix.Config


config :what_is_better_to_pay,
  bot_name: System.get_env("TELEGRAM_BOT_NAME"),
  import_document_example_url: System.get_env("IMPORT_DOCUMENT_EXAMPLE_URL"),
  google_client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :what_is_better_to_pay, WhatIsBetterToPay.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10

config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN")
