use Mix.Config

config :what_is_better_to_pay,
  bot_name: System.get_env("TELEGRAM_BOT_NAME"),
  import_document_example_url: System.get_env("IMPORT_DOCUMENT_EXAMPLE_URL"),
  google_client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  ecto_repos: [WhatIsBetterToPay.Repo]

config :what_is_better_to_pay, WhatIsBetterToPay.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10

config :nadia,
  token: System.get_env("TELEGRAM_BOT_TOKEN")

config :google_maps,
  api_key: System.get_env("GOOGLE_API_KEY"),
  requester: HTTPoison

import_config "#{Mix.env()}.exs"
